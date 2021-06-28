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
  for_each                    = locals.nsgrules 
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.tamopsrg.name
  network_security_group_name = azurerm_network_security_group.tamopsnsg.name
}
locals { 
nsgrules = {
   
    rdp = {
      name                       = "rdp"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range    = "3389"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    }
 
    sql = {
      name                       = "sql"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "SqlManagement"
      destination_address_prefix = "192.168.2.0/24"
    }
 
    http = {
      name                       = "http"
      priority                   = 201
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "192.168.2.0/24"
    }
  }
 
}
