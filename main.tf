resource "azurerm_resource_group" "tamopsrg" {
  name     = "tamopsrg"
  location = "eastus2"
}
 
resource "azurerm_network_security_group" "tamopsnsg" {
  name                = "tamopstest"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.tamopsrg.name
 
}
 
resource "azurerm_network_security_rule" "testrules" {
  name                       = "rdp"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range    = "3389"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "*"
  resource_group_name         = azurerm_resource_group.tamopsrg.name
  network_security_group_name = azurerm_network_security_group.tamopsnsg.name
}
