# output block 
# https://developer.hashicorp.com/terraform/language/values/outputs
# output-1: resource group name 
output "rg_name_out" {
  value = azurerm_resource_group.dev_rg1.name
}

# output-2: resource group id 
output "rg_id_out" {
  value = azurerm_resource_group.dev_rg1.id
}

# output-3: resource group location 
output "rg_location_out" {
  value = azurerm_resource_group.dev_rg1.location
}

# output-4: public ip address
output "pupip_address_out" {
  value = azurerm_public_ip.dev_pubip01.ip_address
}

# output-5: Network interface id 
output "nic_id_out" {
  value = azurerm_network_interface.dev_nic01.id
}

