variable "storage_account_name_prefix" {
  description = "Prefix for storage account name"
  type        = string
}

variable "random_suffix" {
  description = "Random suffix for storage account"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
}

variable "storage_replication_type" {
  description = "Storage replication type"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}
