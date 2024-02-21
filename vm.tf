
resource "azurerm_resource_group" "ateaexample" {
  name     = "ateaeksempel"
  location = "norwayeast"
}

resource "azurerm_virtual_network" "ateeksnet" {
  name                = "ateaeks-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.ateaexample.location
  resource_group_name = azurerm_resource_group.ateaexample.name
}

resource "azurerm_subnet" "ateasub_example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.ateaexample.name
  virtual_network_name = azurerm_virtual_network.ateeksnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "atetestnic" {
  name                = "ateatest-nic"
  location            = azurerm_resource_group.ateaexample.location
  resource_group_name = azurerm_resource_group.ateaexample.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ateasub_example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "ateaexample" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.ateaexample.name
  location            = azurerm_resource_group.ateaexample.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.atetestnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}