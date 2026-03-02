output "subnet_id_frontend" {
    value = azurerm_subnet.frontend.id
    description = "subnet id for the public exposed frontend"
}

output "subnet_id_backend" {
    value = azurerm_subnet.backend.id
    description = "subnet for the aks backend"
}

output "subnet_id_database" {
    value = azurerm_subnet.database.id
    description = "[Optional] subnet for the database"
}

output "vnet_name" {
    value = azurerm_virtual_network.vnet.name
    description = "Name of the virtual network"
}
