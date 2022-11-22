terraform {


}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
  use_msi = true
}


data "azurerm_client_config" "current" {}

module "app_service_plan" {
  source              = "./app_service_plan"
  app_service_name    = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "application_insights" {
  source                    = "./application_insights"
  application_insights_name = var.application_insights_name
  application_type          = var.application_type
  location                  = var.location
  resource_group_name       = var.resource_group_name

}

module "azure_function_app" {
  source                     = "./azure_function"
  function_app_name          = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = module.app_service_plan.azurerm_service_plan
  storage_account_name       = var.storage_account_name
  storage_account_access_key = "https://ibinderkeyvaultstore.vault.azure.net/secrets/StorageAccountKey/fb39436bc0ac4e149c693e71fda977bd"
  depends_on                 = [module.app_service_plan]


}
