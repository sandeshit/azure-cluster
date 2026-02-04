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
    random = {
      source  = "hashicorp/random"
      version = "~>3.7.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subcription_id
}
