resource "azurerm_network_security_group" "mySG" {
  name                = "terraform-security-group"
  location            = azurerm_resource_group.myrgrp.location
  resource_group_name = azurerm_resource_group.myrgrp.name
}

resource "azurerm_network_security_rule" "connect_https" {
  name                        = "Allo-to-connecthttps"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrgrp.name
  network_security_group_name = azurerm_network_security_group.mySG.name
} 

resource "azurerm_network_security_rule" "allow_SSH" {
  name                        = "Allo-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myrgrp.name
  network_security_group_name = azurerm_network_security_group.mySG.name
} 