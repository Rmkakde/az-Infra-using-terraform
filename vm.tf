resource "azurerm_virtual_machine" "myvm" {
  name                  = "terraform-vm"
  location              = azurerm_resource_group.myrgrp.location
  resource_group_name   = azurerm_resource_group.myrgrp.name
  network_interface_ids = [azurerm_network_interface.myNic.id]
  vm_size               = "Standard_DS1_v2"
  
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "terraform-vm01-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "terraform-vm01"
    admin_username = "testadmin"
    admin_password = "${file("../pass.txt")}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "terraform"
    owner = "rk"
  }
}