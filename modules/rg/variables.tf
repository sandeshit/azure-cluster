variable "resource_group_location" {
  type        = string
  default     = "West Europe"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group for the subscription ID."
}
