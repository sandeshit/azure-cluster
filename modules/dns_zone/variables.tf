variable "zone_name" {
  type        = string
  description = "The DNS zone domain name (e.g., example.com)."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the DNS zone will be created."
}
