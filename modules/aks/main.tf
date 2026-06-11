# Managed Identity for AKS
resource "azurerm_user_assigned_identity" "aks" {
  name                = "aks-identity"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.environment
    module      = "aks"
  }
}

# Virtual Network for AKS
resource "azurerm_virtual_network" "aks" {
  name                = "aks-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.aks_vnet_prefix]

  tags = {
    environment = var.environment
    module      = "aks"
  }
}

# Subnet for AKS
resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = [var.aks_subnet_prefix]
}

# Network Security Group for AKS
resource "azurerm_network_security_group" "aks" {
  name                = "aks-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.environment
    module      = "aks"
  }
}

# NSG Association
resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks.id
}

# Azure Container Registry
resource "azurerm_container_registry" "aks" {
  name                = "acr${var.random_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  admin_enabled       = true
  sku                 = "Standard"

  tags = {
    environment = var.environment
    module      = "aks"
  }
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "aks" {
  name                = "aks-logs"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_retention_days

  tags = {
    environment = var.environment
    module      = "aks"
  }
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name           = "default"
    node_count     = var.aks_node_count
    vm_size        = var.aks_node_vm_size
    vnet_subnet_id = azurerm_subnet.aks.id

    tags = {
      environment = var.environment
      module      = "aks"
    }
  }

  identity {
    type           = "UserAssigned"
    identity_ids   = [azurerm_user_assigned_identity.aks.id]
  }

  network_profile {
    network_plugin = var.aks_network_plugin
    service_cidr   = var.aks_service_cidr
    dns_service_ip = var.aks_dns_service_ip
  }

  oms_agent {
    log_analytics_workspace_id              = azurerm_log_analytics_workspace.aks.id
    msi_auth_for_monitoring_enabled         = true
  }

  role_based_access_control_enabled = true

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  tags = {
    environment = var.environment
    module      = "aks"
  }

  depends_on = [
    azurerm_role_assignment.aks_acr
  ]
}

# ACR Pull Role Assignment
resource "azurerm_role_assignment" "aks_acr" {
  scope              = azurerm_container_registry.aks.id
  role_definition_name = "AcrPull"
  principal_id       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# GPU Node Pool (Optional)
resource "azurerm_kubernetes_cluster_node_pool" "gpu" {
  name                  = "gpu"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  node_count            = var.aks_gpu_node_count
  vm_size               = var.aks_gpu_node_vm_size
  vnet_subnet_id        = azurerm_subnet.aks.id

  tags = {
    environment = var.environment
    module      = "aks"
    pool_type   = "gpu"
  }
}
