variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "random_suffix" {
  description = "Random suffix for ACR name"
  type        = string
}

variable "aks_cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix for AKS"
  type        = string
}

variable "aks_node_count" {
  description = "Default node count"
  type        = number
}

variable "aks_node_vm_size" {
  description = "Default node VM size"
  type        = string
}

variable "aks_gpu_node_count" {
  description = "GPU node count"
  type        = number
}

variable "aks_gpu_node_vm_size" {
  description = "GPU node VM size"
  type        = string
}

variable "aks_network_plugin" {
  description = "Network plugin"
  type        = string
}

variable "aks_service_cidr" {
  description = "Service CIDR"
  type        = string
}

variable "aks_dns_service_ip" {
  description = "DNS service IP"
  type        = string
}

variable "aks_vnet_prefix" {
  description = "VNet address space"
  type        = string
}

variable "aks_subnet_prefix" {
  description = "Subnet address prefix"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Log Analytics retention days"
  type        = number
}
