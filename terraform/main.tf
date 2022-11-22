terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "ibinderresourcegroup"
    storage_account_name = "ibinderstorage"
    container_name       = "ibinderstoragecontainer"
    key                  = "ibinder.tfstate"
    subscription_id      = "ae6cbacb-2eac-42cc-978e-516b8ef7628d"
    tenant_id            = "7bb1a8e5-59ee-489d-86f5-a50210ae3970"
    access_key           = "fHFaFigXVWYb9gf6DHOeA/0Z+B5/AJrzSKT0vevEz4/nuD/mY2ImIK3/kKVo90II8eA08PbOtJub+AStJxU01Q"
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  subscription_id            = "ae6cbacb-2eac-42cc-978e-516b8ef7628d"
  tenant_id                  = "7bb1a8e5-59ee-489d-86f5-a50210ae3970"
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
  storage_account_name       = module.azurerm_storage_account.storage_account_name
  storage_account_access_key = module.azurerm_storage_account.storage_account_access_key
  depends_on                 = [module.app_service_plan]


}
