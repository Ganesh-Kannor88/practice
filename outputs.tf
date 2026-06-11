# Resource Group Outputs
output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Resource group location"
  value       = azurerm_resource_group.main.location
}

# Storage Outputs
output "storage_account_name" {
  description = "Storage account name"
  value       = module.storage.storage_account_name
}

output "storage_account_id" {
  description = "Storage account ID"
  value       = module.storage.storage_account_id
}

# VM Outputs
output "vm_public_ips" {
  description = "Public IPs of VMs"
  value       = module.vms.vm_public_ips
}

output "vm_private_ips" {
  description = "Private IPs of VMs"
  value       = module.vms.vm_private_ips
}

output "vm_names" {
  description = "VM names"
  value       = module.vms.vm_names
}

# AKS Outputs
output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.aks_cluster_name
}

output "aks_cluster_id" {
  description = "AKS cluster ID"
  value       = module.aks.aks_cluster_id
}

output "aks_api_server_url" {
  description = "AKS API server URL"
  value       = module.aks.aks_api_server_url
}

output "aks_node_rg" {
  description = "AKS node resource group"
  value       = module.aks.aks_node_rg
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.aks.acr_login_server
}

output "kubectl_config_command" {
  description = "Command to configure kubectl"
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${module.aks.aks_cluster_name}"
}
