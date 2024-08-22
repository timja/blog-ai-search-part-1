locals {
  indexer_json = {
    name : "example",
    dataSourceName : "example",
    targetIndexName : "example",
    parameters : {
      configuration : {
        indexedFileNameExtensions : ".html",
        imageAction : "none"
      }
    }
  }
}

// https://learn.microsoft.com/en-us/rest/api/searchservice/preview-api/create-or-update-indexer
resource "restapi_object" "indexer" {
  path         = "/indexers"
  query_string = "api-version=2023-10-01-Preview"
  data         = jsonencode(local.indexer_json)
  id_attribute = "name" # The ID field on the response
  depends_on   = [azurerm_search_service.this, restapi_object.index, restapi_object.storage_account_datasource]
}
