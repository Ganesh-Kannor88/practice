terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
    }
    random = {
        source  = "hashicorp/random"
        version = "~> 3.5.0"
    }
  }
  required_version = ">=1.9.0"
}

provider "azurerm" {
    subscription_id = "b7ce2be8-439a-4bf8-90ab-a28c88ee3714"
    features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_storage_account" "example" {
 
  name                     = "techtutorial${random_id.suffix.hex}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}