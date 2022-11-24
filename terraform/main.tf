provider "azurerm" {
  features {}
}


data "azurerm_client_config" "current" {}

module "azurerm_service_plan" {
  source                = "./app_service_plan"
  resource_group_name   = var.resource_group_name
  app_service_plan_name = var.app_service_plan_name
  location              = var.location
}
