terraform {
  #  backend "azurerm" {} # uncomment to store the state file in Azure
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    restapi = {
      source = "Mastercard/restapi"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "restapi" {
  uri                  = "https://${azurerm_search_service.this.name}.search.windows.net"
  write_returns_object = true

  headers = {
    "api-key"      = azurerm_search_service.this.primary_key,
    "Content-Type" = "application/json"
  }
}
