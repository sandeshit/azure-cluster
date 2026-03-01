variable "cluster_name" {
  type        = string
  default     = "toggle-cluster-619"
  description = "Name of the cluster for the subscription ID."
}

variable "cluster_dns_prefix" {
  type        = string
  default     = "dns-toggle-619"
  description = "DNS prefix for the cluster"
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}

variable "resource_group_name" {
  type        = string
  default     = "toggle-rg-619"
  description = "Name of the resource group for the subscription ID."
}

variable "resource_group_location" {
  type        = string
  default     = "West Europe"
  description = "Location of the resource group."
}

variable "acr_name" {
  type        = string
  description = "Name of the acr"
  default     = "toggle-acr-619"
}
