data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  depends_on          = [azurerm_resource_group.rg]
  name                = "kv-genomics"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"

  purge_protection_enabled  = true
  enable_rbac_authorization = true

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = ["103.57.133.216"]
  }

  tags = local.common_tags
}

resource "azurerm_key_vault_key" "cmk" {
  depends_on   = [azurerm_key_vault.kv]
  name         = "genomics-cmk"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 4096
  key_opts     = ["decrypt", "encrypt", "sign", "verify", "wrapKey", "unwrapKey"]
}
