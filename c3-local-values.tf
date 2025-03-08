# local values block 
# https://developer.hashicorp.com/terraform/language/values/locals
locals {
  rg_name     = "${terraform.workspace}-${var.resource_group_location_var}-${var.resource_group_name_var}"
  rg_location = var.resource_group_location_var
  # vnet_name   = "${var.environment_var}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.virtual_network_name_var}"
  # subnet_name = "${var.environment_var}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.virtual_network_name_var}-${var.subnet_name_var}"
  # nsg_name    = "${var.environment_var}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.network_security_group_name_var}"
  # pip_name    = "${var.environment_var}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.public_ip_address_name_var}"
  # nic_name    = "${var.environment_var}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.network_interface_name_var}"
  vnet_name   = "${terraform.workspace}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.virtual_network_name_var}"
  subnet_name = "${terraform.workspace}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.virtual_network_name_var}-${var.subnet_name_var}"
  nsg_name    = "${terraform.workspace}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.network_security_group_name_var}"
  pip_name    = "${terraform.workspace}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.public_ip_address_name_var}"
  nic_name    = "${terraform.workspace}-${var.resource_group_location_var}-${var.resource_group_name_var}-${var.network_interface_name_var}"
  vm_name     = var.vm_name_var

  cloud_name = "azure"
  env_name   = "dev"
  tag01      = "test01"
  common_tags = {
    cloud    = local.cloud_name
    env      = local.env_name
    tag_test = local.tag01
    Tag1 = "Terraform-Cloud-Demo1"
  }

}