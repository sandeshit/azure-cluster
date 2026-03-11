variable "subscription_name" {
  type        = string
  description = "Budget name"
}

variable "amount" {
  type        = number
  default = 100
  description = "Budget amount"
}

variable "time_grain" {
  type        = string
  default     = "Monthly"
}

variable "contact_emails" {
  type        = list(string)
  default     = [
    "sudip.khanal@togglecorp.com",
    "sandesh.thapa@togglecorp.com",
  ]
}
variable "subscription_id" {
  type = string
  description = "The subscription id used for azure authentication"
  sensitive = true
}

variable "thresholds" {
  description = "List of thresholds"
  type = list(object({
    threshold      = number
    operator       = string
    threshold_type = string
  }))
  default = [
    {
      
      threshold = 50
      operator  = "GreaterThan"
      threshold_type = "Actual"
    },
    {
      threshold = 80
      operator  = "GreaterThan"
      threshold_type = "Actual"
    },
    {
      threshold = 100
      operator  = "EqualTo"
      threshold_type = "Actual"
    }
  ]
}