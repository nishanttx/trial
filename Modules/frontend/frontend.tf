locals {
  environment_name = var.rg_frontend_name
  resourcegroup_name = var.nishant_rg
  location  = var.location
}

resource "azurerm_app_service_plan" "my_asp" {
  name = local.environment_name
  resource_group_name = locals.resourcegroup_name
  location = local.location
  sku {
      tier = "Standard"
      size = "S1"
  }
}

resource "azurerm_app_service" "MyWebApp" {
  name =  "NishantwebAPP"
  location = local.location
  resource_group_name = local.resourcegroup_name
  app_service_plan_id = azurerm_app_service_plan.my_asp.id
 }
resource "azurerm_function_app" "MyWebApp" {
  name                       = locals.environment_name
  location                   = locals.location
  resource_group_name        = locals.resourcegroup_name
  app_service_plan_id        = azurerm_app_service_plan.MyWebApp.id
  storage_account_name       = var.backend.resource.azurerm_storage_account.nishant_storage.name
  storage_account_access_key = var.backend.resource.azurerm_storage_account.nishant_storage.primary_access_key

}
resource "azurerm_function_app_slot" "MyWebApp" {
  name                       = "test-azure-functions_slot"
  location                   = local.location
  resource_group_name        = local.resourcegroup_name
  app_service_plan_id        = azurerm_app_service_plan.MyWebApp.id
  function_app_name          = azurerm_function_app.MyWebApp.name
  storage_account_name       = var.backend.resource.azurerm_storage_account.nishant_storage.name
  storage_account_access_key = var.backend.resource.azurerm_storage_account.nishant_storage.primary_access_key

}