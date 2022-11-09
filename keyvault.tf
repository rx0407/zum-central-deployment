resource "azurerm_key_vault" "secrets" {
  name                        = "${var.resource_group_name}-vault"
  location                    = azurerm_resource_group.resource_group.location
  resource_group_name         = azurerm_resource_group.resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 30
  purge_protection_enabled    = true

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "keyvault_cluster_policy" {
  key_vault_id = azurerm_key_vault.secrets.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azuread_service_principal.k8s_user.object_id

  key_permissions = [
    "List",
    "Get",
    "Create",
    "Delete",
    "Recover",
    "Encrypt",
    "Decrypt"
  ]

  secret_permissions = [
    "List",
    "Get",
    "Set",
    "Delete",
    "Recover"
  ]

  storage_permissions = [
    "List",
    "Get",
    "Set",
    "Delete",
    "Recover"
  ]

  certificate_permissions = [
    "List",
    "Get"
  ]
}

resource "azurerm_key_vault_certificate" "adapter_cn3_dev" {
  name         = "adapter-cn3-dev-tls-cert"
  key_vault_id = azurerm_key_vault.secrets.id

  certificate {
    contents = acme_certificate.adapter_cn3_dev.certificate_p12
    password = acme_certificate.adapter_cn3_dev.certificate_p12_password
  }
}

resource "azurerm_key_vault_certificate" "adapter_cn3_staging" {
  name         = "adapter-cn3-staging-tls-cert-v2"
  key_vault_id = azurerm_key_vault.secrets.id

  certificate {
    contents = acme_certificate.adapter_cn3_staging.certificate_p12
    password = acme_certificate.adapter_cn3_staging.certificate_p12_password
  }
}

resource "azurerm_key_vault_certificate" "adapter_cn3_prod" {
  name         = "adapter-cn3-prod-tls-cert"
  key_vault_id = azurerm_key_vault.secrets.id

  certificate {
    contents = acme_certificate.adapter_cn3_prod.certificate_p12
    password = acme_certificate.adapter_cn3_prod.certificate_p12_password
  }
}

resource "azurerm_key_vault_certificate" "adapter_nar_prod" {
  name         = "adapter-nar-prod-tls-cert"
  key_vault_id = azurerm_key_vault.secrets.id

  certificate {
    contents = acme_certificate.adapter_nar_prod.certificate_p12
    password = acme_certificate.adapter_nar_prod.certificate_p12_password
  }
}
