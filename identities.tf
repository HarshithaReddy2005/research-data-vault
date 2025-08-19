resource "azurerm_user_assigned_identity" "stg_identity" {
  name                = "uai-stg-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

