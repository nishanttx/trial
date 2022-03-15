locals {
  environment_name = var.rg_backend_name
  rg_name = var.nishant_rg
  my_location   = var.location
}
resource "azurerm_network_security_group" "backendsecuritygroup" {
  name                = "backend-security-group"
  location            = locals.my_location
  resource_group_name = local.rg_name
}

resource "azurerm_virtual_network" "backendVnet" {
  name                = "backend-network"
  location            = locals.my_location
  resource_group_name = locals.rg_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.backendVnet.id
  }

  tags = {
    environment = "backend"
  }
}

resource "azurerm_storage_account" "nishant_storage" {
  name = "nishantstorage"
  resource_group_name = local.rg_name
  location = local.my_location
  account_tier = "Standard"
  account_replication_type = "GRS"

}