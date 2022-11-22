terraform {
  required_providers {
    azurerm = {
    source = "hashicorp/azurerm"
    # version = "=2.46.0"
    }

  }
}
provider "azurerm" {
  subscription_id = "ae6cbacb-2eac-42cc-978e-516b8ef7628d"
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  tenant_id       = "7bb1a8e5-59ee-489d-86f5-a50210ae3970"
  #skip_provider_registration = "true"
  features {}
  use_msi = true
}
