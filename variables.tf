variable "resource_group_name" {
  type    = string
  default = "zum-central"
}

variable "location" {
  type    = string
  default = "chinanorth3"
}

variable "subscriptions" {
  type    = list(string)
  default = ["8a0c0950-8f30-4313-8f4a-7f934e6d8953"]
}

variable "subscription_id" {
  type    = string
  default = "8a0c0950-8f30-4313-8f4a-7f934e6d8953"

}

variable "tenant_id" {
  type    = string
  default = "a12a82ff-eb68-4d6d-b3c7-c4fb2d2220e5"
}

variable "email_address" {
  type    = string
  default = "rui.xia@altenchina.com"

}