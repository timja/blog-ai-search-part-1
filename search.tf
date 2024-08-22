resource "azurerm_search_service" "this" {
  name                = "example"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "basic"
  replica_count       = 1
  partition_count     = 1

  # Allow key auth to be used for the restapi provider
  local_authentication_enabled = true
  # Enable RBAC auth for the most secure authentication for the application
  authentication_failure_mode = "http403"
  semantic_search_sku         = "standard"

  identity {
    type = "SystemAssigned"
  }
}

# permission for search service to access the storage account
resource "azurerm_role_assignment" "storage_blob_data_reader_search_service" {
  principal_id = azurerm_search_service.this.identity[0].principal_id
  scope        = azurerm_storage_account.default.id

  role_definition_name = "Storage Blob Data Reader"
}
