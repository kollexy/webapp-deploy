
# App Service Plan


resource "azurerm_service_plan" "asp" {
  name                = "${var.resource_group_name}-asp"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

# App Service




resource "azurerm_linux_web_app" "apps" {
  name                  = "${var.resource_group_name}-appservice"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  service_plan_id       = azurerm_service_plan.asp.id
  https_only            = false
  site_config { 
    minimum_tls_version = "1.2"
  }
}

resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.apps.id
  repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  branch             = "master"
  use_manual_integration = true
  use_mercurial      = false
}

# Private Endpoint for App Service
resource "azurerm_private_endpoint" "pep" {
  name                = "${var.resource_group_name}-private-endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id   ####azurerm_subnet.appservice_subnet.id

  private_service_connection {
    name                           = "apps-privateserviceconnection"
    private_connection_resource_id = azurerm_app_service.apps.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}

# ##binding

# resource "azurerm_app_service_custom_hostname_binding" "appsvc_binding" {
#   hostname            = "test.devopslabs.uk"
#   app_service_name    = azurerm_app_service.apps.name
#   resource_group_name = var.resource_group_name
# }
