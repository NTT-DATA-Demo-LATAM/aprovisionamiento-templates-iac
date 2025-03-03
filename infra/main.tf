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

resource "azurerm_redis_cache" "redis" {
  name                = "myredis"
  location            = var.location
  resource_group_name = var.resource_group
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
}

variable "location" {
  description = "The Azure region where the Redis cache should be created."
}

variable "resource_group" {
  description = "The name of the resource group where the Redis cache should be created."
}

output "redis_hostname" {
  value = azurerm_redis_cache.redis.hostname
}

output "redis_port" {
  value = azurerm_redis_cache.redis.ssl_port
}