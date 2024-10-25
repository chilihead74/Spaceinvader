module "Test-VM" {
source = "./modules/VM"
admin_username = "admin"
admin_password = "Admin1234!"
disable_password_authentication = false
vm_size = "Standard_F2"
image_offer = "0001-com-ubuntu-server-jammy"
image_sku = "22_04_lts"
image_version = "latest"
image_publisher = "Canonical"
os_disk_name = "Disk1"
computer_name = "MyComp"
vm_name = "MyVM"
resource_group_name = azurerm_resource_group.Rob.name
subnet_id = azurerm_subnet.subnet01.id
location = azurerm_resource_group.Rob.location
nic_name = "NIC01"








}
resource "azurerm_resource_group" "Rob" {
  name     = "SpaceInvader"
  location = "swedencentral"
}

resource "azurerm_virtual_network" "VNET" {
  address_space       = ["10.0.0.0/16"]
  name                = "VNET"
  location            = azurerm_resource_group.Rob.location
  resource_group_name = azurerm_resource_group.Rob.name
  tags = {
    "owner" = "michael.winzinger@redbull.com"
  }
}

resource "azurerm_subnet" "subnet01" {
  address_prefixes     = ["10.0.0.0/16"]
  name                 = "SN01"
  virtual_network_name = azurerm_virtual_network.VNET.name
  resource_group_name  = azurerm_resource_group.Rob.name
}
