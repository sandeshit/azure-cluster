resource "azurerm_dns_zone" "toggle_dns_zone" {
  name                = var.zone_name
  resource_group_name = var.resource_group_name
}


