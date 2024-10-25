# Create a resource group
resource "azurerm_resource_group" "robrg" {
  name     = "spaceinvaders"
  location = "francecentral"
   tags = {
    owner = "robert.messner@redbull.com"
  }
}
  resource "azurerm_network_interface" "interface1" {
  name                = "Space-nic"
  location            = azurerm_resource_group.robrg.location
  resource_group_name = azurerm_resource_group.robrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "spacenetwork" {
  name                = "spacenetwork"
  resource_group_name = azurerm_resource_group.robrg.name
  location            = azurerm_resource_group.robrg.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.robrg.name
  virtual_network_name = azurerm_virtual_network.spacenetwork.name
  address_prefixes     = ["10.0.3.0/24"]
}
resource "azurerm_linux_virtual_machine" "example" {
  name                = "Space-VM"
  resource_group_name = azurerm_resource_group.robrg.name
  location            = azurerm_resource_group.robrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = false
  admin_password = "Admin1234!"

  network_interface_ids = [
    azurerm_network_interface.interface1.id,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}