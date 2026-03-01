
resource "azurerm_dns_cname_record" "toggle_dns_cname" {
  name                = var.cname_record_name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.cname_record_ttl
  record              = var.cname_record_target
}
