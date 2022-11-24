provider "azurerm" {
  features {}
}


data "azurerm_client_config" "current" {}

module "azurerm_resource_group" {
  source              = "./resource_group"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "azurerm_service_plan" {
  name     = var.app_service_plan_name
  location = var.location
}
