resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"


  variable "location" {
  type = string
}

variable "account_tier" {
    type = string
}

variable "resource_group_name" {
  type = string
}
