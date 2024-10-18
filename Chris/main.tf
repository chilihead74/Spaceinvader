# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-christian"
  location = "West Europe"
   tags = {"owner" = "christian.peuker@redbull.com"}
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "net-christian"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
  tags = {"owner" = "christian.peuker@redbull.com"}
}