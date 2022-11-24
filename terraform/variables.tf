# Input variable definitions
variable "location" {
  description = "The Azure Region in which all resources groups should be created."
  type        = string
  default     = "northeurope"
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "ibindergroup"
}
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "ibinderstorageaccount"
}
variable "storage_account_tier" {
  description = "Storage Account Tier"
  type        = string
  default     = "Standard"
}

variable "app_service_plan_name" {
  description = "App service plan name"
  type        = string
  default     = "ibinderappservice"
}


variable "application_insights_name" {
  description = "Application insights name"
  type        = string
  default     = "ibinderapplicationinsights"
}

variable "application_type" {
  type    = string
  default = "web"
}
