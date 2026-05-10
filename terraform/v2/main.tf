terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "ml2568"
    storage_account_name = "terraformrgazure"
    container_name       = "terraform-state"
    key                  = "v2.tfstate"
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

  subscription_id = var.subscription_id

  resource_provider_registrations = "none"
}

variable "subscription_id" {}

module "resource_group" {
  source = "../modules/resource-group"

  resource_group_name = "rg-githubactions-demo2"
  location            = "Central India"
}