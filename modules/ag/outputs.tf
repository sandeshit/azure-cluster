output "ag_id" {
  value = azurerm_application_gateway.ag.id
}

output "ag_public_ip_id" {
  value = azurerm_public_ip.agpublicip.id
}
