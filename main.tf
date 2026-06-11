# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
  }
}

# Random ID for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}

# Storage Module
module "storage" {
  source = "./modules/storage"

  storage_account_name_prefix = var.storage_account_name_prefix
  random_suffix               = random_id.suffix.hex
  resource_group_name         = azurerm_resource_group.main.name
  location                    = azurerm_resource_group.main.location
  storage_account_tier        = var.storage_account_tier
  storage_replication_type    = var.storage_replication_type
  environment                 = var.environment
}

# VMs Module
module "vms" {
  source = "./modules/vms"

  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  environment           = var.environment
  vm_count              = var.vm_count
  vm_size               = var.vm_size
  vm_image_publisher    = var.vm_image_publisher
  vm_image_offer        = var.vm_image_offer
  vm_image_sku          = var.vm_image_sku
  vm_admin_username     = var.vm_admin_username
  vm_vnet_prefix        = var.vm_vnet_prefix
  vm_subnet_prefix      = var.vm_subnet_prefix
}

# AKS Module
module "aks" {
  source = "./modules/aks"

  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  environment                  = var.environment
  random_suffix                = random_id.suffix.hex
  aks_cluster_name             = var.aks_cluster_name
  aks_dns_prefix               = var.aks_dns_prefix
  aks_node_count               = var.aks_node_count
  aks_node_vm_size             = var.aks_node_vm_size
  aks_gpu_node_count           = var.aks_gpu_node_count
  aks_gpu_node_vm_size         = var.aks_gpu_node_vm_size
  aks_network_plugin           = var.aks_network_plugin
  aks_service_cidr             = var.aks_service_cidr
  aks_dns_service_ip           = var.aks_dns_service_ip
  aks_vnet_prefix              = var.aks_vnet_prefix
  aks_subnet_prefix            = var.aks_subnet_prefix
  log_analytics_retention_days = var.log_analytics_retention_days
}