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

  # create a VM
resource "azurerm_network_interface" "example" {
  name                = "nic-christian"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_public_ip" "example" {
  name = "ip-public"
  location            = azurerm_resource_group.example.location
  allocation_method = "Dynamic"
  resource_group_name = azurerm_resource_group.example.name
}


resource "azurerm_linux_virtual_machine" "VM-Chris" {
  name                = "vm-christian"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password = "Admin1234!"
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.example.id,
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

