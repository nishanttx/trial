
#azureeeeeeeeeeeeeeeeeeeee
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
resource "azurerm_resource_group" "nishant_rg" {
  name=var.nishant_rg
  location = "east us"
  
}
module "frontend" {
  source = "./modules/frontend"
  main_rg=var.main_rg
  rg_frontend_name=azurerm_resource_group.nishant_rg.name
  location=azurerm_resource_group.nishant_rg.location
}


module "backend" {
  source = "./modules/backend"
  # main_rg=var.main_rg
  rg_backend_name=azurerm_resource_group.nishant_rg.name
  location=azurerm_resource_group.nishant_rg.location
}

