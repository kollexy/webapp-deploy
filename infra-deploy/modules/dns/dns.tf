resource "azurerm_private_dns_zone" "dns" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "${var.resource_group_name}-dns-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = var.vnetid    ###azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_a_record" "dnsa" {
  name                = var.appsvc_name    ####azurerm_app_service.apps.name
  zone_name           = azurerm_private_dns_zone.dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [var.private_ip_address] #### azurerm_private_endpoint.pep.private_ip_address
}
