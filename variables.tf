variable "storageAccount_name" {
  description = "(Required) The name of the storage account resource."
  type        = string
  validation {
    condition     = can(regex("^([a-z]+)$", var.storageAccount_name))
    error_message = "Invalid storage account name, the name must contain only lowercase letters'"
  }
}

variable "resource_group" {
  description = "(Required) The resource group of the storage account."
  type        = string
}

variable "location" {
  description = "(Required) The location of the storage account."
  type        = string
}

variable "subnet_id" {
  description = "(Required) the subnet where the private endpoint will be created."
  type        = string
}

variable "account_tier" {
  description = "(Optional) The tier of the storage account."
  default     = "Standard"
  type        = string
  validation {
    condition     = can(regex("^(Standard|Premium)$", var.account_tier))
    error_message = "Invalid account tier, only allowed values are: 'Standard', 'Premium'. Default 'Standard'"
  }
}

variable "account_replication_type" {
  description = "(Optional) Specifies the replication strategy."
  default     = "RAGRS"
  type        = string
  validation {
    condition     = can(regex("^(LRS|GRS|RAGRS|ZRS|GZRS|RAGZRS)$", var.account_replication_type))
    error_message = "Invalid replication type, only allowed types are: 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS', 'RAGZRS'. Default 'RAGRS'"
  }
}

variable "log_analytics_workspace_id" {
  description = "(Optional) ID of the log analytics workspace to which the diagnostic setting will send the logs of this resource."
  type        = string
  default     = null
}

variable "private_endpoint_manual_connection" {
  description = "(Optional) Specify whether the approval of the private endpoint connection is handled manually."
  default     = true
  type        = bool
}

variable "private_endpoint_subresource" {
  description = "(Optional) Specifies the names of the sub-resources within the target service that the private endpoint should connect to."
  default     = ["table"]
  type        = set(string)
}

variable "diagnostic_setting_categories" {
  description = "value"
  type = list(string)
  default = [ "StorageDelete", "StorageRead", "StorageWrite"]
}