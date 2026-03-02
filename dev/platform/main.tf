data "terraform_remote_state" "core" {
  backend = "azurerm"
  config = {
      resource_group_name = "tfstate"
      storage_account_name = "toggletfstate619"
      container_name = "tfstate"
      key = "dev-core.tfstate"
    }
}

module "vnet" {
  source = "../../modules/vnet"
  resource_group_name = data.terraform_remote_state.core.outputs.resource_group_name
  resource_group_location = data.terraform_remote_state.core.outputs.resource_group_location
  vnet_address_space = ["10.0.0.0/16"]
}

module "waf" {
  source = "../../modules/waf"
  waf_name = "togglewaf619"
  resource_group_name = data.terraform_remote_state.core.outputs.resource_group_name
  resource_group_location = data.terraform_remote_state.core.outputs.resource_group_location
}

module "ag" {
  source = "../../modules/ag"
  ag_name = "toggleag619"
  resource_group_name = data.terraform_remote_state.core.outputs.resource_group_name
  resource_group_location = data.terraform_remote_state.core.outputs.resource_group_location
  subnet_id = module.vnet.subnet_id_frontend
  firewall_policy_id = module.waf.waf_id
}

module "aks" {
  source             = "../../modules/aks"
  cluster_name       = "toggle-cluster-619"
  cluster_dns_prefix = "dns-toggle-619"
  resource_group_name = data.terraform_remote_state.core.outputs.resource_group_name
  resource_group_location = data.terraform_remote_state.core.outputs.resource_group_location
  acr_name = data.terraform_remote_state.core.outputs.acr_name
  node_count = 3
  vnet_subnet_id = module.vnet.subnet_id_backend
  dns_service_ip = "10.1.0.10"
  service_cidr      = "10.1.0.0/16"
  gateway_id = module.ag.ag_id
  resource_group_id = data.terraform_remote_state.core.outputs.resource_group_id
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

module "dns_record" {
  source = "../../modules/dns_record"
  resource_group_name = data.terraform_remote_state.core.outputs.resource_group_name
  zone_name = data.terraform_remote_state.core.outputs.zone_name
  target_resource_id = module.ag.ag_public_ip_id
}
