#define virtual network
resource "azurerm_virtual_network" "myVnet" {
  name                = "terraform-vnet"
  location            = azurerm_resource_group.myrgrp.location
  resource_group_name = azurerm_resource_group.myrgrp.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "terraform"
  }
}

#define subnet
resource "azurerm_subnet" "subnet01" {
  name                 = "terra-vnet-subnet01"
  resource_group_name  = azurerm_resource_group.myrgrp.name
  virtual_network_name = azurerm_virtual_network.myVnet.name
  address_prefixes     = ["10.0.0.0/17"]
}
resource "azurerm_subnet" "subnet02" {
  name                 = "terra-vnet-subnet02"
  resource_group_name  = azurerm_resource_group.myrgrp.name
  virtual_network_name = azurerm_virtual_network.myVnet.name
  address_prefixes     = ["10.0.128.0/17"]
}


#define public ip
resource "azurerm_public_ip" "myPubIp" {
  name                = "dynamic-terra-pbip"
  resource_group_name = azurerm_resource_group.myrgrp.name
  location            = azurerm_resource_group.myrgrp.location
  allocation_method   = "Dynamic"
}

#define network interface
resource "azurerm_network_interface" "myNic" {
  name                = "terraform-nic"
  location            = azurerm_resource_group.myrgrp.location
  resource_group_name = azurerm_resource_group.myrgrp.name
  
  ip_configuration {
    name                          = "terra-vnet-subnet01"
    subnet_id                     = azurerm_subnet.subnet02.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myPubIp.id
  }
  tags = {
    environment = "terraform"
  }
}
