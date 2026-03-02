resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.resource_group_location
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_dns_prefix

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
    vnet_subnet_id = var.vnet_subnet_id
  }
  network_profile {
    network_plugin    = "azure"          # Azure CNI for VNet integration
    load_balancer_sku = "standard"
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

# NOTE: see the official documentation for why this is done.
  ingress_application_gateway {
    gateway_id = var.gateway_id  
    }
   tags = {
    Environment = "Production"
  }
}

data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "agic_contributor" {
  principal_id   = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
  role_definition_name = "Contributor"
  scope          = var.gateway_id
}

resource "azurerm_role_assignment" "agic_reader" {
  principal_id   = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
  role_definition_name = "Reader"
  scope          = var.resource_group_id
}
