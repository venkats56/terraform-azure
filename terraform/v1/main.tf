terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "ml2568"
    storage_account_name = "terraformrgazure"
    container_name       = "terraform-state"
    key                  = "v1.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}
module "resource_group" {
  source = "../modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
}
output "rg_name" {
  value = module.resource_group.resource_group_name
}