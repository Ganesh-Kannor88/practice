# Resource Group Variables
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "West Europe"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "testing"
}

# Storage Account Variables
variable "storage_account_name_prefix" {
  description = "Prefix for storage account name"
  type        = string
  default     = "techtutorial"
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

# VM Variables
variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "vm_image_publisher" {
  description = "VM image publisher"
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "VM image offer"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "vm_image_sku" {
  description = "VM image SKU"
  type        = string
  default     = "22_04-lts-gen2"
}

variable "vm_admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureuser"
}

variable "vm_subnet_prefix" {
  description = "Subnet address prefix for VMs"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vm_vnet_prefix" {
  description = "Virtual network address space for VMs"
  type        = string
  default     = "10.0.0.0/16"
}

# AKS Variables
variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "aks-cluster"
}

variable "aks_dns_prefix" {
  description = "DNS prefix for AKS cluster"
  type        = string
  default     = "aks-cluster"
}

variable "aks_node_count" {
  description = "Default node pool count for AKS"
  type        = number
  default     = 2
}

variable "aks_node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "aks_gpu_node_count" {
  description = "GPU node pool count for AKS"
  type        = number
  default     = 1
}

variable "aks_gpu_node_vm_size" {
  description = "GPU VM size for AKS nodes"
  type        = string
  default     = "Standard_NC6s_v3"
}

variable "aks_network_plugin" {
  description = "Network plugin for AKS"
  type        = string
  default     = "azure"
}

variable "aks_service_cidr" {
  description = "Service CIDR for AKS"
  type        = string
  default     = "10.1.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "DNS service IP for AKS"
  type        = string
  default     = "10.1.0.10"
}

variable "aks_subnet_prefix" {
  description = "Subnet address prefix for AKS"
  type        = string
  default     = "172.16.1.0/24"
}

variable "aks_vnet_prefix" {
  description = "Virtual network address space for AKS"
  type        = string
  default     = "172.16.0.0/16"
}

variable "log_analytics_retention_days" {
  description = "Log Analytics retention in days"
  type        = number
  default     = 30
}
