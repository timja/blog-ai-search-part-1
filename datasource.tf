locals {
  datasource_json = {
    name : "example",
    description : "Example datasource",
    type : "azureblob",
    credentials : {
      connectionString : "ResourceId=${azurerm_storage_account.default.id};"
    },
    container : {
      name : "example",
    },
    dataDeletionDetectionPolicy : {
      "@odata.type" : "#Microsoft.Azure.Search.NativeBlobSoftDeleteDeletionDetectionPolicy",
    },
  }
}

# https://learn.microsoft.com/en-us/rest/api/searchservice/create-data-source
resource "restapi_object" "storage_account_datasource" {
  path         = "/datasources"
  query_string = "api-version=2023-10-01-Preview"
  data         = jsonencode(local.datasource_json)
  id_attribute = "name" # The ID field on the response
  depends_on = [
    azurerm_search_service.this,
    azurerm_role_assignment.storage_blob_data_reader_search_service
  ]
}
