resource "azurerm_resource_group" "light_yagami" {
  name     = "SpaceInvader-LightYagami"
  location = "West Europe"
   tags     = {
        "owner"          = "michael.winzinger@redbull.com"
    }
}