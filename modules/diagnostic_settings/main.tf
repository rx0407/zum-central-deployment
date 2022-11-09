data "azurerm_monitor_diagnostic_categories" "diag_categories" {
  resource_id = var.resource_id
}

locals {
  # logs_destinations_ids = var.logs_destinations_ids == null ? [] : var.logs_destinations_ids
  # enabled               = length(local.logs_destinations_ids) > 0

  log_categories = data.azurerm_monitor_diagnostic_categories.diag_categories.log_category_types
  metric_categories = data.azurerm_monitor_diagnostic_categories.diag_categories.metrics

  logs = {
    for category in data.azurerm_monitor_diagnostic_categories.diag_categories.log_category_types : category => {
      enabled        = true
      retention_days = var.diag_retention_days
    }
  }

  metrics = {
    for metric in data.azurerm_monitor_diagnostic_categories.diag_categories.metrics : metric => {
      enabled        = true
      retention_days = var.diag_retention_days
    }
  }

}

resource "azurerm_monitor_diagnostic_setting" "diag_settings" {
  name               = "diag-settings"
  target_resource_id = var.resource_id


  log_analytics_workspace_id     = var.log_analytics_id

  dynamic "log" {
    for_each = local.logs

    content {
      category = log.key
      

      retention_policy {
        enabled = log.value.retention_days != null ? true : false
        days    = log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = local.metrics

    content {
      category = metric.key
      

      retention_policy {
        enabled = metric.value.retention_days != null ? true : false
        days    =  metric.value.retention_days
      }
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}