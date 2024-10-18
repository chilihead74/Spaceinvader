# Create a resource group
resource "azurerm_resource_group" "pdey" {
  name     = "pdey-test"
  location = "Australia Central"

  tags = {
    team = "Engineering"
    owner = "p.no.spam.dey@redbull.com"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "pdey" {
  name                = "pdey-net"
  resource_group_name = azurerm_resource_group.pdey.name
  location            = azurerm_resource_group.pdey.location
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet
resource "azurerm_subnet" "neuralnet" {
  name                 = "neuralnet"
  resource_group_name = azurerm_resource_group.pdey.name
  virtual_network_name = azurerm_virtual_network.pdey.name
  address_prefixes     = ["10.0.2.0/24"]
}

# All the secrets
resource "azurerm_key_vault" "accessdenied" {
  name                        = "access-denied"
  location                    = azurerm_resource_group.pdey.location
  resource_group_name         = azurerm_resource_group.pdey.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Update", "Create", "Delete"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete"
    ]

    storage_permissions = [
      "Get", "List", "Set", "Delete"
    ]
  }
}