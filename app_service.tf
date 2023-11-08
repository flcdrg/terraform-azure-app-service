resource "azurerm_service_plan" "plan" {
  name                = "plan-tfappservice-australiasoutheast"
  location            = data.azurerm_resource_group.group.location
  resource_group_name = data.azurerm_resource_group.group.name

  os_type  = "Windows"
  sku_name = "B1"

}

resource "azurerm_windows_web_app" "webapp" {
  name                = "app-tfappservice-australiasoutheast"
  resource_group_name = data.azurerm_resource_group.group.name
  location            = data.azurerm_resource_group.group.location
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true

  # site configuration
  site_config {
    minimum_tls_version = "1.2"
    ftps_state          = "FtpsOnly"

    application_stack {
      current_stack = "node"
      node_version  = "~12" # "6.9.1" # Must be one of ~12, ~14, ~16, and ~18
    }
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
  }
}
