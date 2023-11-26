output "servicebus_namespace_id" {
  value = azurerm_servicebus_namespace.default.id
}

output "servicebus_queue_id" {
  value = azurerm_servicebus_queue.storage_events.id
}
