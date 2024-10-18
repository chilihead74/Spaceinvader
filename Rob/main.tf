# Create a resource group
resource "azurerm_resource_group" "robrg" {
  name     = "spaceinvaders"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "spacenetwork" {
  name                = "spacenetwork"
  resource_group_name = azurerm_resource_group.robrg.name
  location            = azurerm_resource_group.robrg.location
  address_space       = ["10.0.0.0/16"]
}