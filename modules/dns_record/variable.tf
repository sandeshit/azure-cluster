
variable "cname_record_name" {
  type        = string
  default     = "*"
  description = "The subdomain for the CNAME record (e.g., 'www' for www.example.com)."
}

variable "cname_record_ttl" {
  type        = number
  default     = 300
  description = "TTL (Time To Live) for the CNAME record, in seconds."
}

variable "cname_record_target" {
  type        = string
  description = "The target hostname the CNAME record points to (e.g., app.example.com)."
}

variable "zone_name" {
  type = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the DNS zone will be created."
}
