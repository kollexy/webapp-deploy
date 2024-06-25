
# App Service Plan
resource "azurerm_app_service_plan" "asp" {
  name                = "${var.resource_group_name}-asp"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

# App Service
resource "azurerm_app_service" "apps" {
  name                = "${var.resource_group_name}-appservice"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    ftps_state     = "Disabled"
    scm_type       = "LocalGit"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
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
