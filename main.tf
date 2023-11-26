terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.81.0"
    }
  }
}

locals {
  workload = "bigfactory"
}

resource "azurerm_resource_group" "default" {
  name     = "rg-${local.workload}"
  location = var.location
}

module "storage" {
  source              = "./modules/storage"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

# module "eventhub" {
#   source              = "./modules/eventhub"
#   workload            = local.workload
#   resource_group_name = azurerm_resource_group.default.name
#   location            = azurerm_resource_group.default.location
# }

module "eventgrid" {
  source              = "./modules/eventgrid"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  storage_id          = module.storage.storage_id
}
