variable "location" {
  type    = string
  default = "northeurope"
}

variable "resource_group_name" {
  type    = string
  default = "ibinderrg2"
}

variable "storage_account_name" {
  type    = string
  default = "ibinderstorageaccount"
}

variable "storage_container_name" {
  type    = string
  default = "ibinderstoragecontainer"
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}


variable "app_service_name" {
  type    = string
  default = "ibinderappserviceplan"
}

variable "application_insights_name" {
  type    = string
  default = "ibinderappinsights"
}


variable "application_type" {
  type    = string
  default = "web"
}

variable "storage_account_access_key" {
  type    = string
  default = "https://ibinderKeys.vault.azure.net/secrets/StorageContainerAccessKey"
}

variable "app_service_plan_id" {
  type    = string
  default = ""
}

variable "function_app_name" {
  type    = string
  default = "ibinderfunctionapp"
}


variable "subscription_id" {
  type    = string
  default = "ae6cbacb-2eac-42cc-978e-516b8ef7628d"
}

variable "tenant_id" {
  type    = string
  default = "7bb1a8e5-59ee-489d-86f5-a50210ae3970"
}
