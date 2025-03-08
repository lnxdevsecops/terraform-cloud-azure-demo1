# resource 2: creating resource gorup 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "dev_rg1" {
  name     = local.rg_name
  location = local.rg_location
  tags     = local.common_tags
}