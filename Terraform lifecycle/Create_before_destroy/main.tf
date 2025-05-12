terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
    }
  }
  required_version = ">=1.9.0"
}

provider "azurerm" {
    features {
      
    }
  
}
resource "random_string" "unique_suffix" {
  length  = 6
  upper   = true
  special = false
}
resource "azurerm_resource_group" "example" {
  name     = "barath-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "barath${random_string.unique_suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }

   lifecycle {
    create_before_destroy = true
  }
}