resource "azurerm_servicebus_namespace" "default" {
  name                = "bus-${var.workload}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
}

resource "azurerm_servicebus_queue" "storage_events" {
  name         = "storage-events"
  namespace_id = azurerm_servicebus_namespace.default.id

  enable_partitioning = true
}
