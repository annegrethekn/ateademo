terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.49.0"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

provider "azurerm" {
subscription_id                     = "29617337-a06e-4788-96db-e7056df65be8"
client_id                           = "bc07f24a-278b-4a94-a214-4a7fce3b583b"
client_secret                       = "4UY8Q~Z-qZnIjVQNMAIrFZ50v-p1IwRDYeb91cJA"
tenant_id                           = "db0cb781-b1c3-4ab8-b789-af161847f80b"
  features {}
}