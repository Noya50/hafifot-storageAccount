output "id" {
  value       = azurerm_storage_account.this.id
  description = "The id of the storage account."
}

output "name" {
  value       = azurerm_storage_account.this.name
  description = "The name of the storage account."
}

output "location" {
  value       = azurerm_storage_account.this.location
  description = "The location of the storage account."
}

output "resource_group_name" {
  value       = azurerm_storage_account.this.resource_group_name
  description = "The name of the resource group of the storage account."
}
