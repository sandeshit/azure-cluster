
resource "azurerm_dns_a_record" "toggle_dns_arecord" {
  name                = var.a_record_name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.a_record_ttl
  target_resource_id  = var.target_resource_id
}
