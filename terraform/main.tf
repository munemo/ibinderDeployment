terraform {
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
  use_msi = true
}


data "azurerm_client_config" "current" {}



module "azure_function_app" {
  source                     = "./azure_function"
  function_app_name          = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = module.app_service_plan.azurerm_service_plan
  storage_account_name       = var.storage_account_name
  storage_account_access_key = "https://ibinderkeyvaultstore.vault.azure.net/secrets/StorageAccountKey/fb39436bc0ac4e149c693e71fda977bd"

}
