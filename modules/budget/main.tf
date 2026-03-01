
# subscription budget

resource "azurerm_consumption_budget_subscription" "toggle_subscription" {
  name            = var.subscription_name
  subscription_id = "/subscriptions/${var.subscription_id}"
  amount     = var.amount
  time_grain = var.time_grain

  time_period {
    start_date = formatdate("YYYY-MM-01T00:00:00Z", timestamp())
    }
    
 dynamic "notification" {
  for_each = var.thresholds
  iterator = threshold_item

  content {
    enabled        = true
    threshold      = threshold_item.value.threshold
    operator       = threshold_item.value.operator
    threshold_type = threshold_item.value.threshold_type

    contact_emails = var.contact_emails
  }
}

}