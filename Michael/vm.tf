
resource "azurerm_network_interface" "nic" {
  location            = azurerm_resource_group.light_yagami.location
  resource_group_name = azurerm_resource_group.light_yagami.name
  name                = "nic"
  ip_configuration {
    name                          = "nicconf"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm"
  location              = azurerm_resource_group.light_yagami.location
  resource_group_name   = azurerm_resource_group.light_yagami.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    name                 = "osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    # disk_size_gb = 30
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-12"
    sku       = "12"
    version   = "latest"
  }
}