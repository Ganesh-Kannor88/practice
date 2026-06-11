# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "vm-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vm_vnet_prefix]

  tags = {
    environment = var.environment
    module      = "vms"
  }
}

# Subnet
resource "azurerm_subnet" "main" {
  name                 = "vm-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.vm_subnet_prefix]
}

# Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = "vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_rdp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
    module      = "vms"
  }
}

# NSG Association
resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Public IPs
resource "azurerm_public_ip" "main" {
  count               = var.vm_count
  name                = "vm-pip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.environment
    module      = "vms"
  }
}

# Network Interfaces
resource "azurerm_network_interface" "main" {
  count               = var.vm_count
  name                = "vm-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vmConfig"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[count.index].id
  }

  tags = {
    environment = var.environment
    module      = "vms"
  }
}

# Virtual Machines
resource "azurerm_virtual_machine" "main" {
  count                 = var.vm_count
  name                  = "vm-${count.index + 1}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  vm_size               = var.vm_size
  network_interface_ids = [azurerm_network_interface.main[count.index].id]

  delete_os_disk_on_deletion    = true
  delete_data_disks_on_deletion = true

  storage_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = "latest"
  }

  storage_os_disk {
    name              = "vm-${count.index + 1}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "vm${count.index + 1}"
    admin_username = var.vm_admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.vm_admin_username}/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  tags = {
    environment = var.environment
    module      = "vms"
    name        = "vm-${count.index + 1}"
  }
}
