resource "azurerm_eventgrid_system_topic" "storage" {
  name                   = "storage-topic"
  resource_group_name    = var.resource_group_name
  location               = var.location
  source_arm_resource_id = var.storage_id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  identity {
    type = "SystemAssigned"
  }
}
