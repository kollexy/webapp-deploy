output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet" {
  value = azurerm_virtual_network.vnet.name
}

output "vnetid" {
  value = azurerm_virtual_network.vnet.id
}

output "rg_location" {
  value = azurerm_resource_group.rg.location
}

output "snetid" {
    value = azurerm_subnet.appservice_subnet.id  
}

# output "fwsnet" {
#     value = azurerm_subnet.firewall_subnet.id
  
# }

output "pepsnet" {
    value = azurerm_subnet.pep_subnet.id
  
}

output "agwsnet" {
    value = azurerm_subnet.agw_subnet.id
  
}