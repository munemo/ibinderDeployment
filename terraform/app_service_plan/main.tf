resource "azurerm_service_plan" "azurerm_service_plan" {
  name              = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name = "D1"
  os_type = "Windows"
}
