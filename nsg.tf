# NSG for Backend Subnet
resource "azurerm_network_security_group" "nsg_backend" {
  name                = "nsg-backend"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-LogAnalytics"
    direction                  = "Outbound"
    access                     = "Allow"
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureMonitor"
    source_port_range          = "*"
    destination_port_range     = "443"
  }

  security_rule {
    name                       = "Allow-PE-DNS"
    direction                  = "Outbound"
    access                     = "Allow"
    priority                   = 200
    protocol                   = "Udp"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureDNS"
    source_port_range          = "*"
    destination_port_range     = "53"
  }

  security_rule {
    name                       = "Deny-Internet-All"
    direction                  = "Outbound"
    access                     = "Deny"
    priority                   = 300
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Internet"
    source_port_range          = "*"
    destination_port_range     = "*"
  }
}

# NSG for Jumphost Subnet
resource "azurerm_network_security_group" "nsg_jumphost" {
  name                = "nsg-jumphost"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-Jumphost-RDP"
    direction                  = "Inbound"
    access                     = "Allow"
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = var.jumphost_allowed_ip
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
  }

  security_rule {
    name                       = "Deny-Internet-All"
    direction                  = "Outbound"
    access                     = "Deny"
    priority                   = 300
    protocol                   = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
    source_port_range          = "*"
    destination_port_range     = "*"
  }
}

# NSG for HPC Subnet
resource "azurerm_network_security_group" "nsg_hpc" {
  name                = "nsg-hpc"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Associate NSGs to Subnets
resource "azurerm_subnet_network_security_group_association" "backend_assoc" {
  subnet_id                 = azurerm_subnet.sn_backend.id
  network_security_group_id = azurerm_network_security_group.nsg_backend.id
}

resource "azurerm_subnet_network_security_group_association" "jumphost_assoc" {
  subnet_id                 = azurerm_subnet.sn_jumphost.id
  network_security_group_id = azurerm_network_security_group.nsg_jumphost.id
}

resource "azurerm_subnet_network_security_group_association" "hpc_assoc" {
  subnet_id                 = azurerm_subnet.sn_hpc.id
  network_security_group_id = azurerm_network_security_group.nsg_hpc.id
}
