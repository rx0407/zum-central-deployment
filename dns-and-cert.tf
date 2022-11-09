resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.email_address
}

# ARGOCD

data "azurerm_dns_zone" "argocd" {
  name                = "argocd.ci.zum-vwac.com"
  resource_group_name = data.azurerm_resource_group.manual.name
}

resource "acme_certificate" "certificate" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = data.azurerm_dns_zone.argocd.name

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET   = azuread_service_principal_password.dns_user.value
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.argocd.name
      AZURE_ENVIRONMENT     = "china"
    }
  }

  # Added since TF is trying to change it, will be replaced with provided certs anyway
  lifecycle {
    ignore_changes = all
  }

  depends_on = [azurerm_role_assignment.dns_user]
}

# ADAPTER TMP

data "azurerm_dns_zone" "adapter_cn3_dev" {
  name                = "adapter.cn3.dev.zum-vwac.com"
  resource_group_name = data.azurerm_resource_group.manual.name
}

data "azurerm_dns_zone" "adapter_cn3_staging" {
  name                = "adapter.cn3.staging.zum-vwac.com"
  resource_group_name = data.azurerm_resource_group.manual.name
}

data "azurerm_dns_zone" "adapter_cn3_prod" {
  name                = "adapter.cn3.zum-vwac.com"
  resource_group_name = data.azurerm_resource_group.manual.name
}

data "azurerm_dns_zone" "adapter_nar_prod" {
  name                = "adapter.aoa.zum-vwac.com"
  resource_group_name = data.azurerm_resource_group.manual.name
}

resource "acme_certificate" "adapter_cn3_dev" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = "*.${data.azurerm_dns_zone.adapter_cn3_dev.name}"

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET   = azuread_service_principal_password.dns_user.value
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.adapter_cn3_dev.name
      AZURE_ENVIRONMENT     = "china"
    }
  }

  depends_on = [azurerm_role_assignment.dns_user]
}

resource "acme_certificate" "adapter_cn3_staging" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = "*.${data.azurerm_dns_zone.adapter_cn3_staging.name}"

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET   = azuread_service_principal_password.dns_user.value
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.adapter_cn3_staging.name
      AZURE_ENVIRONMENT     = "china"
    }
  }

  depends_on = [azurerm_role_assignment.dns_user]
}

resource "acme_certificate" "adapter_cn3_prod" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = "*.${data.azurerm_dns_zone.adapter_cn3_prod.name}"

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET   = azuread_service_principal_password.dns_user.value
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.adapter_cn3_prod.name
      AZURE_ENVIRONMENT     = "china"
    }
  }

  depends_on = [azurerm_role_assignment.dns_user]
}

resource "acme_certificate" "adapter_nar_prod" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = "*.${data.azurerm_dns_zone.adapter_nar_prod.name}"

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET   = azuread_service_principal_password.dns_user.value
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.adapter_nar_prod.name
      AZURE_ENVIRONMENT     = "china"
    }
  }

  depends_on = [azurerm_role_assignment.dns_user]
}
