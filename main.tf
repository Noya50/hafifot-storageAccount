resource "azurerm_storage_account" "this" {
  name                     = var.storageAccount_name
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  lifecycle {
    ignore_changes = [tags]
  }
}

module "work_storageAccount_privateEndpoint" {
  source = "github.com/Noya50/hafifot-privateEndpoint.git"

  location                       = var.location
  resource_group                 = var.resource_group
  subnet_id                      = var.subnet_id
  connected_resource_name        = var.storageAccount_name
  is_manual_connection           = var.private_endpoint_manual_connection
  subresource_names              = var.private_endpoint_subresource
  private_connection_resource_id = azurerm_storage_account.this.id
  depends_on                     = [azurerm_storage_account.this]
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

module "diagnostic_setting" {
  source = "github.com/Noya50/hafifot-diagnosticSetting.git"

  name                       = "${azurerm_storage_account.this.name}-diagnostic-setting-tf"
  target_resource_id         = azurerm_storage_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

module "blob_diagnostic_setting" {
  source = "github.com/Noya50/hafifot-diagnosticSetting.git"

  name                       = "${azurerm_storage_account.this.name}-blob-diagnostic-setting-tf"
  target_resource_id         = "${azurerm_storage_account.this.id}/blobServices/default/"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  diagnostic_setting_categories = var.diagnostic_setting_categories
}

module "file_diagnostic_setting" {
  source = "github.com/Noya50/hafifot-diagnosticSetting.git"

  name                       = "${azurerm_storage_account.this.name}-file-diagnostic-setting-tf"
  target_resource_id         = "${azurerm_storage_account.this.id}/fileServices/default/"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  diagnostic_setting_categories = var.diagnostic_setting_categories
}

module "queue_diagnostic_setting" {
  source = "github.com/Noya50/hafifot-diagnosticSetting.git"

  name                       = "${azurerm_storage_account.this.name}-queue-diagnostic-setting-tf"
  target_resource_id         = "${azurerm_storage_account.this.id}/queueServices/default/"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  diagnostic_setting_categories = var.diagnostic_setting_categories
}

module "table_diagnostic_setting" {
  source = "github.com/Noya50/hafifot-diagnosticSetting.git"

  name                       = "${azurerm_storage_account.this.name}-table-diagnostic-setting-tf"
  target_resource_id         = "${azurerm_storage_account.this.id}/tableServices/default/"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  diagnostic_setting_categories = var.diagnostic_setting_categories
}
