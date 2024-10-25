# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-christian"
  location = "West Europe"
   tags = {"owner" = "christian.peuker@redbull.com"}
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "vnet-christian"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
  tags = {"owner" = "christian.peuker@redbull.com"}
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "example" {
  name                 = "snet-christian"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

 module "Chris-VM" {
source = "./modules/VM"
admin_username = "admin"
admin_password = "Admin1234!"
disable_password_authentication = false
vm_size = "Standard_F2"
image_offer = "0001-com-ubuntu-server-jammy"
image_sku = "22_04_lts"
image_version = "latest"
image_publisher = "Cononical"
os_disk_name = "Disk1"
computer_name = "MyComp"
vm_name = "MyVM"
resource_group_name = azurerm_resource_group.example.name
subnet_id = azurerm_subnet.example.id
location = azurerm_resource_group.example.location
nic_name = "NIC01"








}

