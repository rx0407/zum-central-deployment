variable "resource_id" {
  type = string
  description = "the azure resrouce id for the resource that diagnostic settings should be enabled on."
}

variable "log_analytics_id" {
  type = string
  description = "the azure resource id for the log analytics workspace that diagnostics will be sent to."
}

variable "diag_retention_days" {
  type = number
  description = "number of the days that logs will be kept"
  default = 30
}
