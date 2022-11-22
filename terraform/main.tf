terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
provider "azurerm" {
  skip_provider_registration = "true"
  features {}
  use_msi = true
}


data "azurerm_client_config" "current" {}

module "azurerm_app_service_plan" {
  source              = "./app_service_plan"
  app_service_name    = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tier                = "Dynamic"
  size                = "Y1"



}

module "azure_function_app" {
  source                     = "./azure_function"
  function_app_name          = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = "/subscriptions/ee6e8a42-2a70-406d-a749-18c554337870/resourcegroups/ibinderresourcegroup/providers/Microsoft.Web/serverfarms/ibinder"
  storage_account_name       = var.storage_account_name
  storage_account_access_key = "https://ibinderkeyvaultstore.vault.azure.net/secrets/StorageAccountKey/fb39436bc0ac4e149c693e71fda977bd"

}

