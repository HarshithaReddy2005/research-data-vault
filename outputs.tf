output "resource_group_name" { value = azurerm_resource_group.rg.name }
output "vnet_name" { value = azurerm_virtual_network.vnet.name }
output "storage_account_name" { value = azurerm_storage_account.stg.name }
output "key_vault_name" { value = azurerm_key_vault.kv.name }
output "log_analytics_name" { value = azurerm_log_analytics_workspace.law.name }
