terraform {
  backend "azurerm" {
    resource_group_name  = "ibinderrg"
    storage_account_name = "ibinderstorageaccount"
    container_name       = "ibinderstoragecontainer"
    key                  = "ibinder.tfstate"
    subscription_id      = var.subscription_id
    tenant_id            = var.tenant_id
    access_key           = var.storage_account_access_key
  }
}
provider "azurerm" {
  skip_provider_registration = "true"
  subscription_id            = var.subscription_id
  features {}
  use_msi = true
}
data "azurerm_client_config" "current" {}

module "resource_group" {
  source              = "./resource_group"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "azurerm_storage_account" {
  source                   = "./storage_account"
  storage_account_name     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  depends_on               = [module.resource_group]
}

module "storage_container" {
  source               = "./storage_container"
  name                 = var.storage_container_name
  storage_account_name = var.storage_account_name
  depends_on           = [module.azurerm_storage_account]
}


module "app_service_plan" {
  source              = "./app_service_plan"
  app_service_name    = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on          = [module.resource_group]
}

module "application_insights" {
  source                    = "./application_insights"
  application_insights_name = var.application_insights_name
  application_type          = var.application_type
  location                  = var.location
  resource_group_name       = var.resource_group_name
  depends_on                = [module.resource_group]

}


module "azure_function_app" {
  source                     = "./azure_function"
  function_app_name          = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = module.app_service_plan.azurerm_service_plan
  storage_account_name       = module.azurerm_storage_account.storage_account_name
  storage_account_access_key = module.azurerm_storage_account.storage_account_access_key
  depends_on                 = [module.app_service_plan, module.azurerm_storage_account]
}
