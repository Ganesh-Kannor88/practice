terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Note: To use Azure backend later, uncomment below and update values
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "example-resources"
#     storage_account_name = "tfstate2389"
#     container_name       = "tfstate"
#     key                  = "prod.terraform.tfstate"
#   }
# }

