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

variable "admin_username" {
  type    = string
  default = "ec2-user"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}


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