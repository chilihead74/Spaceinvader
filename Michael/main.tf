resource "azurerm_resource_group" "light_yagami" {
  name     = "SpaceInvader-LightYagami"
  location = "West Europe"
   tags     = {
        "environment"    = "sandbox"
        "internal-order" = "INTOUTCLDINF"
        "owner"          = "dmitrii.tyryshkin@redbull.com"
    }
}