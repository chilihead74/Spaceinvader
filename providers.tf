terraform {
  cloud {
    organization = "SpaceAgency"
    workspaces {
      name = "Spaceinvader"
    }
  }
 
  required_version = ">= 1.1.0"
}
 
provider "azurerm" {
  features {}
}