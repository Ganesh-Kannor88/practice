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

variable "vm_count" {
  description = "Number of VMs"
  type        = number
}

variable "vm_size" {
  description = "VM size"
  type        = string
}

variable "vm_image_publisher" {
  description = "VM image publisher"
  type        = string
}

variable "vm_image_offer" {
  description = "VM image offer"
  type        = string
}

variable "vm_image_sku" {
  description = "VM image SKU"
  type        = string
}

variable "vm_admin_username" {
  description = "Admin username"
  type        = string
}

variable "vm_vnet_prefix" {
  description = "VNet address space"
  type        = string
}

variable "vm_subnet_prefix" {
  description = "Subnet address prefix"
  type        = string
}
