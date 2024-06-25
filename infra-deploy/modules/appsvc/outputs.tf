output "private_endpoint_address" {
  value = azurerm_private_endpoint.pep.private_service_connection[0].private_ip_address
}

output "appsvc_name" {
    value = azurerm_linux_web_app.apps.name
  
}

output "appsvc_host_name" {
    value = azurerm_linux_web_app.apps.default_site_hostname
  
}