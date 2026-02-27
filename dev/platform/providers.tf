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
     helm ={
      source = "hashicorp/helm"
      version = "3.1.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "toggletfstate619"
    container_name       = "tfstate"
    key                  = "plat-core.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

#NOTE: No race condition when configuring Helm provider using AKS module outputs in same Terraform run. 
// Terraform builds a dependency graph first, 
// Detects provider depends on module.aks, 
// Ensures the AKS cluster is created before initializing the Helm provider and applying Helm resources.
provider "helm" {
  kubernetes = {
    host                   = module.aks.host
    username               = module.aks.cluster_username
    password               = module.aks.cluster_password
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}
