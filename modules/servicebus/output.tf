output "servicebus_namespace_id" {
  value = azurerm_servicebus_namespace.default.id
}

output "azurerm_servicebus_queue" {
  value = azurerm_servicebus_queue.storage_events.id
}
