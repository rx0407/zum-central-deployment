variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
<<<<<<< Updated upstream
=======
  default = "chinanorth3"
  #  default = "Germany West Central"
>>>>>>> Stashed changes
}

variable "subscriptions" {
  type    = list(string)
<<<<<<< Updated upstream
=======
  default = ["8a0c0950-8f30-4313-8f4a-7f934e6d8953"]
  #  default = ["00000000-0000-0000-0000-000000000000"]
>>>>>>> Stashed changes
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "email_address" {
  type = string
}