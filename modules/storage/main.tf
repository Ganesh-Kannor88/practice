resource "azurerm_storage_account" "main" {
  name                     = "${var.storage_account_name_prefix}${var.random_suffix}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type

  tags = {
    environment = var.environment
    module      = "storage"
  }
}
