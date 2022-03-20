terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.98.0"
    }

  }
}
#configure the azure provider
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "example" {
  name     = var.my_rg
  location = "West Europe"
}
module "frontend" {
    source = "./modules/frontend"
    name=azurerm_resource_group.example.rg_name
    location=azurerm_resource_group.example.location
  
}