output "azurerm_service_plan" {
  value       = azurerm_app_service_plan.app_service_plan.id
  description = "The app service plan id"
}