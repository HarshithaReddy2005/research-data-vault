resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-research"
  address_space       = [var.cidr_vnet]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags
}

resource "azurerm_subnet" "sn_backend" {
  name                 = "sn-backend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.cidr_backend]
}

resource "azurerm_subnet" "sn_jumphost" {
  name                 = "sn-jumphost"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.cidr_jumphost]
}

resource "azurerm_subnet" "sn_hpc" {
  name                 = "sn-hpc"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.cidr_hpc]
}
