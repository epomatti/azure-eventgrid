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

# resource "azurerm_eventgrid_system_topic_event_subscription" "example" {
#   name                = "example-event-subscription"
#   system_topic        = azurerm_eventgrid_system_topic.example.name
#   resource_group_name = azurerm_resource_group.example.name

#   # Recommended
#   event_delivery_schema = "CloudEventSchemaV1_0"

#   storage_queue_endpoint {
#     storage_account_id = azurerm_storage_account.example.id
#     queue_name         = azurerm_storage_queue.example.name
#   }
# }
