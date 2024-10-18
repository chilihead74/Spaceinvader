resource "azurerm_network_interface" "mainframe" {
  name                = "mainframe-nic"
  location            = azurerm_resource_group.pdey.location
  resource_group_name = azurerm_resource_group.pdey.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.neuralnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "mainframe" {
  name                = "cosmos"
  resource_group_name = azurerm_resource_group.pdey.name
  location            = azurerm_resource_group.pdey.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "?Sup3rS3cureP4a$$w0rd"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.mainframe.id,
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