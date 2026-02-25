terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>2.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.55.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subcription_id
}
