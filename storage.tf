resource "azurerm_storage_account" "default" {
  name                            = "yourstorageaccountname" # replace me
  location                        = azurerm_resource_group.this.location
  resource_group_name             = azurerm_resource_group.this.name
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  # Required so the indexer can detect deleted files
  blob_properties {
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_storage_container" "example" {
  name                 = "example"
  storage_account_name = azurerm_storage_account.default.name
}
