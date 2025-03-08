# resource - 7: creating linux virtual machine
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "dev_lnx_vm1" {
  name                = local.vm_name
  computer_name       = "${local.vm_name}.com"
  resource_group_name = local.rg_name
  location            = local.rg_location
  size                = "Standard_B1ms"
  admin_username      = "lnxadm"
  admin_ssh_key {
    username = "lnxadm"

    # https://developer.hashicorp.com/terraform/language/functions/file
    public_key = file("./ssh-keys/terraform-azure.pub")
  }

  os_disk {
    # name                 = "osdisk-${var.environment_var}-${random_string.myrandom.id}"
    name                 = "osdisk-${terraform.workspace}-${random_string.myrandom.id}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  network_interface_ids = [
    azurerm_network_interface.dev_nic01.id
  ]

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9-lvm-gen2"
    version   = "latest"
  }
  # https://developer.hashicorp.com/terraform/language/functions/filebase64
  custom_data = filebase64("${path.module}/app-scripts/app1-cloud-init.txt")

  tags = local.common_tags

  # connection block for provisioner to connect azure virtual machine 
  # https://developer.hashicorp.com/terraform/language/resources/provisioners/connection
  connection {
    type        = "ssh"
    host        = self.public_ip_address
    user        = self.admin_username
    private_key = file("./ssh-keys/terraform-azure.pem")
  }

  # File Provisioner-1: Copies the file-copy.html file to /tmp/file-copy.html
  provisioner "file" {
    source      = "apps/file-copy.html"
    destination = "/tmp/file-copy.html"
  }

  # File Provisioner-2: Copies the string in content into /tmp/file.log
  provisioner "file" {
    content     = "VM Host Name: ${self.computer_name}" # Understand what is "self"
    destination = "/tmp/file.log"
  }

  # File Provisioner-3: Copies the app1 folder to /tmp - FOLDER COPY
  provisioner "file" {
    source      = "apps/app1"
    destination = "/tmp"
  }

  # File Provisioner-4: Copies all files and folders in apps/app2 to /tmp - CONTENTS of FOLDER WILL BE COPIED
  provisioner "file" {
    source      = "apps/app2/" # when "/" at the end is added - CONTENTS of FOLDER WILL BE COPIED
    destination = "/tmp"
  }

  # File Provisioner-5: Copies the file-copy.html file to /var/www/html/file-copy.html where "azureuser" don't have permission to copy
  # This provisioner will fail but we don't want to taint the resource, we want to continue on_failure
  provisioner "file" {
    source      = "apps/file-copy.html"
    destination = "/var/www/html/file-copy.html"
    on_failure  = continue # Enable this during Step-05-01 Test-2
  }

  # add thic block while destroying the resources
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
  }

}

