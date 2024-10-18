# Create a resource group
resource "azurerm_resource_group" "pdey" {
  name     = "pdey-test"
  location = "Australia Central"

  tags = {
    team = "Engineering"
    owner = "p.no.spam.dey@redbull.com"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "pdey" {
  name                = "pdey-net"
  resource_group_name = azurerm_resource_group.pdey.name
  location            = azurerm_resource_group.pdey.location
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet
resource "azurerm_subnet" "neuralnet" {
  name                 = "neuralnet"
  resource_group_name = azurerm_resource_group.pdey.name
  virtual_network_name = azurerm_virtual_network.pdey.name
  address_prefixes     = ["10.0.2.0/24"]
}