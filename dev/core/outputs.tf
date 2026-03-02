output "acr_name" {
    value = module.acr.acr_name
}

output "resource_group_name" {
  value = module.rg.resource_group_name
}

output "resource_group_location" {
  value = module.rg.resource_group_location
}

output "zone_name" {
  value = module.dns_zone.zone_name
}

output "name_servers" {
  value = module.dns_zone.name_servers
}

output "resource_group_id" {
  value = module.rg.rg_id
}
