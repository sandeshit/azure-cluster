data "terraform_remote_state" "core" {
  backend = "azurerm"
  config = {
      resource_group_name = "tfstate"
      storage_account_name = "toggletfstate619"
      container_name = "tfstate"
      key = "dev-core.tfstate"
    }
}

module "aks" {
  source             = "../../modules/aks"
  cluster_name       = var.cluster_name
  cluster_dns_prefix = var.cluster_dns_prefix
  resource_group_name = data.terraform_remote_state.core.outputs.resource_group_name
  resource_group_location = data.terraform_remote_state.core.outputs.resource_group_location
  acr_name = data.terraform_remote_state.core.outputs.acr_name
  node_count = var.node_count
}

module "argocd" {
  source = "../../modules/argocd"

  kube_config = {
    host                   = module.aks.host
    username               = module.aks.cluster_username
    password               = module.aks.cluster_password
    client_certificate     = module.aks.client_certificate
    client_key             = module.aks.client_key
    cluster_ca_certificate = module.aks.cluster_ca_certificate
  }
}
