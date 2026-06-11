output "vm_public_ips" {
  description = "Public IPs of VMs"
  value       = azurerm_public_ip.main[*].ip_address
}

output "vm_private_ips" {
  description = "Private IPs of VMs"
  value       = azurerm_network_interface.main[*].private_ip_address
}

output "vm_names" {
  description = "VM names"
  value       = azurerm_virtual_machine.main[*].name
}

output "vnet_id" {
  description = "VNet ID"
  value       = azurerm_virtual_network.main.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = azurerm_subnet.main.id
}
