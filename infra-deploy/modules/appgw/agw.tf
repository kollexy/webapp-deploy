resource "azurerm_public_ip" "agwpip" {
  name                = "example-pip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}



####

resource "azurerm_application_gateway" "agw" {
  name                = "${var.resource_group_name}-appgw"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgatewayipcfg"
    subnet_id = var.agw_subnet_id####azurerm_subnet.app_service_subnet.id 
  }

  frontend_port {
    name = "frontendport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontendipcfg"
    public_ip_address_id = azurerm_public_ip.agwpip.id
  }

  backend_address_pool {
    name = "backendpool"
    fqdns = [var.app_service_hostname]
  }

  backend_http_settings {
    name                  = "backendhttp"
    cookie_based_affinity = "Disabled"
    path                  =  "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "httplistener"
    frontend_ip_configuration_name = "frontendipcfg"
    frontend_port_name             = "frontendport"
    protocol                       = "Http"
    host_name                      =  var.app_service_hostname
  }

  request_routing_rule {
    name                       = "routetobackend"
    priority                   =  10            
    rule_type                  = "Basic"
    http_listener_name         = "httplistener"
    backend_address_pool_name  = "backendpool"
    backend_http_settings_name = "backendhttp"
  }
}



