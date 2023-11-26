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

resource "azurerm_role_assignment" "servicebus_namespace_permissions" {
  scope                = var.service_bus_namespace_id
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = azurerm_eventgrid_system_topic.storage.identity[0].principal_id
}

resource "azurerm_eventgrid_system_topic_event_subscription" "storage_to_servicebus" {
  name                = "storage-event-subscription"
  system_topic        = azurerm_eventgrid_system_topic.storage.name
  resource_group_name = var.resource_group_name

  # Recommended by Microsoft
  event_delivery_schema = "CloudEventSchemaV1_0"

  service_bus_queue_endpoint_id = var.service_bus_queue_endpoint_id

  # Wait for permissions to be granted to the System-Assigned Identity
  depends_on = [azurerm_role_assignment.servicebus_namespace_permissions]
}
