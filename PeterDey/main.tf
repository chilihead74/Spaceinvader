# Create a resource group
resource "azurerm_resource_group" "pdey" {
  name     = "pdey-test"
  location = "West Europe"

  tags = {
    team = "Engineering"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "pdey" {
  name                = "pdey-net"
  resource_group_name = azurerm_resource_group.pdey.name
  location            = azurerm_resource_group.pdey.location
  address_space       = ["10.0.0.0/16"]
}