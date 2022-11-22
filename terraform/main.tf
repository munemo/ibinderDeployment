provider "azurerm" {
   features {}
  subscription_id = "ae6cbacb-2eac-42cc-978e-516b8ef7628d"
  client_id       = "c57a8915-eb12-4d52-bf8e-e71aa280c79a"
  client_secret   = "0q28Q~gvZDfDT3vbJzCy5qD.9wAwggkZbQGLndxf"
  tenant_id       = "7bb1a8e5-59ee-489d-86f5-a50210ae3970"
}


resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}



resource "random_string" "random" {
  length           = 6
  special          = false
  numeric = false
  upper = false
  lower = true
  
}
resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "subnetname"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_storage_account" "example" {
  name                = "${var.storage_account_name}${random_string.random.id}"
  resource_group_name = azurerm_resource_group.example.name

  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.example.id]
  }

  tags = {
    environment = "staging"
  }
}