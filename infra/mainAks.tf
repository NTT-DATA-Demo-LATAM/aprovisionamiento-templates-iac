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
  description = "The Azure region where the AKS cluster should be created."
}

variable "resource_group" {
  description = "The name of the resource group where the AKS cluster should be created."
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myaks"
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "agentpool"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "aks_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}