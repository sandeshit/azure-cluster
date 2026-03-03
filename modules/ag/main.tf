resource "azurerm_public_ip" "agpublicip" {
  name                = "toggleag619-pip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_application_gateway" "ag" {
  name                = var.ag_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  firewall_policy_id = var.firewall_policy_id
  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_id
  }

# Public frontend for the DNS
  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.agpublicip.id
  }

# Private frontend for the AKS
   frontend_ip_configuration {
    name                 = "frontend-private-ip"
    subnet_id            = var.subnet_id  # must be reachable from AKS
    private_ip_address_allocation = "Static"
    private_ip_address   = "10.0.1.10"
  }

  frontend_port {
    name = "http"
    port = 80
  }

  backend_address_pool {
  name = "dummy-backend-pool"
}

backend_http_settings {
  name                  = "dummy-http-settings"
  cookie_based_affinity = "Disabled"
  port                  = 80
  protocol              = "Http"
  request_timeout       = 30
}

http_listener {
  name                           = "dummy-listener"
  frontend_ip_configuration_name = "frontend-ip"
  frontend_port_name             = "http"
  protocol                       = "Http"
}

request_routing_rule {
  name                       = "dummy-rule"
  rule_type                  = "Basic"
  http_listener_name         = "dummy-listener"
  backend_address_pool_name  = "dummy-backend-pool"
  backend_http_settings_name = "dummy-http-settings"
  priority                   = 100
}
lifecycle {
  ignore_changes = [
    backend_address_pool,
    backend_http_settings,
    http_listener,
    request_routing_rule,
    url_path_map,
    probe,
    ssl_certificate,
    rewrite_rule_set,
    trusted_root_certificate
  ]
}
}
