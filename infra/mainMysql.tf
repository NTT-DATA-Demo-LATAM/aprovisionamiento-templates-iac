terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  description = "The Azure region where the MySQL server should be created."
}

variable "resource_group" {
  description = "The name of the resource group where the MySQL server should be created."
}

variable "mysql_admin_password" {
  description = "The password for the MySQL administrator user."
  sensitive   = true
}

resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = "mymysqlserver"
  location               = var.location
  resource_group_name    = var.resource_group
  administrator_login    = "mysqladmin"
  administrator_password = var.mysql_admin_password
  sku_name               = "Standard_B1ms"
  version                = "5.7"
  storage_mb             = 5120
}

output "mysql_server_fqdn" {
  value = azurerm_mysql_flexible_server.mysql.fqdn
}