locals {
  name=var.name
  rg_name=var.rg-name
  location=var.location
}
#vnet config
resource "azurerm_network_security_group" "example" {
  name                = locals.name
  location            = locals.location
  resource_group_name = locals.rg_name
}

resource "azurerm_virtual_network" "example" {
  name                = locals.name
  location            = locals.location
  resource_group_name = locals.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}
#storage account


resource "azurerm_storage_account" "example" {
  name                     = locals.name
  resource_group_name      = locals.rg_name
  location                 = locals.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
#functionapp with app service plan
resource "azurerm_app_service_plan" "example" {
  name                = locals.name
  location            = locals.location
  resource_group_name = locals.rg_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}
resource "azurerm_function_app" "example" {
  name                       = locals.name
  location                   = locals.location
  resource_group_name        = locals.rg_name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
}