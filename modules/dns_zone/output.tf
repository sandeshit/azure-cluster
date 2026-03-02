output "zone_name" {
    value = azurerm_dns_zone.toggle_dns_zone.name
}
output "name_servers" {
  value = azurerm_dns_zone.toggle_dns_zone.name_servers
}
