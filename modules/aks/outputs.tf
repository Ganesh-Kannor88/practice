output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  description = "AKS cluster ID"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_kube_config" {
  description = "Kubernetes config"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "aks_api_server_url" {
  description = "AKS API server URL"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "aks_node_rg" {
  description = "AKS node resource group"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "acr_login_server" {
  description = "ACR login server"
  value       = azurerm_container_registry.aks.login_server
}

output "acr_admin_username" {
  description = "ACR admin username"
  value       = azurerm_container_registry.aks.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "ACR admin password"
  value       = azurerm_container_registry.aks.admin_password
  sensitive   = true
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  value       = azurerm_log_analytics_workspace.aks.id
}
