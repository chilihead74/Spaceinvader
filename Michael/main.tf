resource "azurerm_resource_group" "light_yagami" {
  name     = "SpaceInvader-LightYagami"
  location = "swedencentral"
  tags = {
    "owner" = "michael.winzinger@redbull.com"
  }
}

resource "azurerm_virtual_network" "vnet01" {
  address_space       = ["10.0.0.0/16"]
  name                = "vnet01"
  location            = azurerm_resource_group.light_yagami.location
  resource_group_name = azurerm_resource_group.light_yagami.name
  tags = {
    "owner" = "michael.winzinger@redbull.com"
  }
}

resource "azurerm_subnet" "subnet01" {
  address_prefixes     = ["10.0.0.0/16"]
  name                 = "subnet01"
  virtual_network_name = azurerm_virtual_network.vnet01.name
  resource_group_name  = azurerm_resource_group.light_yagami.name
}