# Create a resource group
resource "azurerm_resource_group" "robrg" {
  name     = "spaceinvaders"
  location = "francecentral"
   tags = {
    owner = "robert.messner@redbull.com"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "spacenetwork" {
  name                = "spacenetwork"
  resource_group_name = azurerm_resource_group.robrg.name
  location            = azurerm_resource_group.robrg.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.robrg.name
  virtual_network_name = azurerm_virtual_network.spacenetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}