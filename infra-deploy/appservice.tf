resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "${azurerm_resource_group.rg.name}-asp"
  location            = azurerm_resource_group.rg.location  
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# App Service
resource "azurerm_linux_web_app" "apps" {
  name                  = "${azurerm_resource_group.rg.name}-appservice"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  service_plan_id       = azurerm_service_plan.asp.id
  https_only            = true
  site_config { 
    minimum_tls_version = "1.2"
    
  }
  app_settings = {
    "PYTHON_VERSION" = "3.12"
  }
}