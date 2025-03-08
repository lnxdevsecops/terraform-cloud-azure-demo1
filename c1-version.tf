# terraform block 
# https://developer.hashicorp.com/terraform/language/terraform
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      version = ">= 4.0"
      source  = "hashicorp/azurerm"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }

  #   # defining terraform backend as azure storage account
  #   # https://developer.hashicorp.com/terraform/language/backend/azurerm
  #   backend "azurerm" {
  #     resource_group_name  = "dev-eastus2-rg01"                # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
  #     storage_account_name = "deveastus2rg01str01"             # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
  #     container_name       = "terraform-state"                 # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
  #     key                  = "terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  #     # subscription_id      = "00000000-0000-0000-0000-000000000000"  # Can also be set via `ARM_SUBSCRIPTION_ID` environment variable.
  #   }
}

# provider block 
# https://developer.hashicorp.com/terraform/language/providers/configuration
provider "azurerm" {
  features {
  }
  subscription_id = "2e1905fb-77fd-4797-b6c4-f56b9b48e011"
}


# Random String Resource
resource "random_string" "myrandom" {
  length  = 6
  upper   = false
  special = false
  numeric = false
}