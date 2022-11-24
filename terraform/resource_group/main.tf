resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Owner   = "john.chimbani"
    DueDate = "2022-11-02"
  }
}
