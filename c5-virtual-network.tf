# resource - 2: creating virtual network 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "dev_vnet01" {
  name                = local.vnet_name
  resource_group_name = local.rg_name
  location            = local.rg_location
  address_space       = var.virtual_network_address_space_var
  tags                = local.common_tags
}

# resource - 3: creating subnet 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "dev_vnet01_subnet1" {
  name                 = local.subnet_name
  resource_group_name  = local.rg_name
  virtual_network_name = azurerm_virtual_network.dev_vnet01.name
  address_prefixes     = var.subnet_address_prefix_var
}

# resource - 4: creating network security group 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "dev_nsg01" {
  name                = local.nsg_name
  resource_group_name = local.rg_name
  location            = local.rg_location

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.common_tags

}

# resource 5: associate network security group with subnet
resource "azurerm_subnet_network_security_group_association" "dev_nsg01_sub1" {
  subnet_id                 = azurerm_subnet.dev_vnet01_subnet1.id
  network_security_group_id = azurerm_network_security_group.dev_nsg01.id
}

# resource 6: creating public ip address 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "dev_pubip01" {
  name                = local.pip_name
  resource_group_name = local.rg_name
  location            = local.rg_location
  allocation_method   = "Static"
  # domain_name_label   = "app1-${var.environment_var}-${random_string.myrandom.id}"
  domain_name_label = "app1-${terraform.workspace}-${random_string.myrandom.id}"
  tags              = local.common_tags
}

# resource 7: creating network interface 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "dev_nic01" {
  name                = local.nic_name
  resource_group_name = local.rg_name
  location            = local.rg_location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev_vnet01_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev_pubip01.id
  }

}


# resource "azurerm_virtual_network" "dev_vnet1" {
#   name                = "dev-vnet1"
#   resource_group_name = azurerm_resource_group.dev_rg1.name
#   location            = azurerm_resource_group.dev_rg1.location
#   address_space       = ["10.1.0.0/16"]
#   tags = {
#     env = "dev"
#   }
# }

# # resource - 3: creating subnet 
# resource "azurerm_subnet" "dev_vnet1_sub1" {
#   name                 = "dev-vnet1-sub1"
#   resource_group_name  = azurerm_resource_group.dev_rg1.name
#   virtual_network_name = azurerm_virtual_network.dev_vnet1.name
#   address_prefixes     = ["10.1.1.0/24"]
# }

# # resource - 4: creating network security group 
# resource "azurerm_network_security_group" "dev_nsg1" {
#   name                = "dev-nsg1"
#   location            = azurerm_resource_group.dev_rg1.location
#   resource_group_name = azurerm_resource_group.dev_rg1.name
#   security_rule {
#     name                       = "Allow-SSH"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "Allow-HTTP"
#     priority                   = 110
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "Allow-HTTPS"
#     priority                   = 120
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "443"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   tags = {
#     env = "dev"
#   }
# }

# # resource 6: associate network security group with subnet
# resource "azurerm_subnet_network_security_group_association" "dev_nsg_sub" {
#   subnet_id                 = azurerm_subnet.dev_vnet1_sub1.id
#   network_security_group_id = azurerm_network_security_group.dev_nsg1.id
# }

# # resource 5: creating public ip address 
# resource "azurerm_public_ip" "dev_pubip1" {
#   name                = "dev-pubip1"
#   resource_group_name = azurerm_resource_group.dev_rg1.name
#   location            = azurerm_resource_group.dev_rg1.location
#   allocation_method   = "Static"
#   domain_name_label   = "app-vm-${random_string.myrandom.id}"
#   depends_on = [
#     azurerm_virtual_network.dev_vnet1,
#     azurerm_subnet.dev_vnet1_sub1,
#     azurerm_network_security_group.dev_nsg1
#   ]
#   tags = {
#     env = "dev"
#   }
# }

# # resource 6: creating network interface 
# resource "azurerm_network_interface" "dev_nic1" {
#   name                = "dev-nic1"
#   resource_group_name = azurerm_resource_group.dev_rg1.name
#   location            = azurerm_resource_group.dev_rg1.location
#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.dev_vnet1_sub1.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.dev_pubip1.id
#   }
# }