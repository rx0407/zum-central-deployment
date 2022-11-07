<<<<<<< Updated upstream
=======
data "azurerm_dns_zone" "argocd" {
  #name                = "argocd.ci.zum.cariad.digital"
  name                = "argocd.ci.zum-vwac.com"
  resource_group_name = data.azurerm_resource_group.manual.name
}

data "azurerm_dns_zone" "audi-v2-emea-dev" {
  #name                = "audi-v2.adapter.emea.dev.zum.cariad.digital"
  name                = "audi-v2.adapter.emea.dev.zum-vwac.com"
  resource_group_name = data.azurerm_resource_group.manual.name
}

>>>>>>> Stashed changes
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
<<<<<<< Updated upstream
  email_address   = var.email_address
}

# ARGOCD

data "azurerm_dns_zone" "argocd" {
  name                = "argocd.ci.zum.cariad.digital"
  resource_group_name = data.azurerm_resource_group.manual.name
=======
  email_address   = "rui.xia@altenchina.com"
>>>>>>> Stashed changes
}

resource "acme_certificate" "certificate" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = data.azurerm_dns_zone.argocd.name

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID     = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET = azuread_service_principal_password.dns_user.value
      #AZURE_CLIENT_ID       = "f5cc2d86-e0d0-4c52-8e69-9b596726ad08"
      #AZURE_CLIENT_SECRET   = "oB5XyqZ870X.V-uADl..348flTVuIx9Bt."
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
<<<<<<< Updated upstream
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
=======
      AZURE_SUBSCRIPTION_ID = "8a0c0950-8f30-4313-8f4a-7f934e6d8953"
      AZURE_TENANT_ID       = "a12a82ff-eb68-4d6d-b3c7-c4fb2d2220e5"
>>>>>>> Stashed changes
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.argocd.name
      AZURE_ENVIRONMENT     = "china"

    }
  }

<<<<<<< Updated upstream
  # Added since TF is trying to change it, will be replaced with provided certs anyway
  lifecycle {
    ignore_changes = all
  }

  depends_on = [azurerm_role_assignment.dns_user]
=======
   depends_on = [azurerm_role_assignment.dns_user]
>>>>>>> Stashed changes
}

# ADAPTER TMP

data "azurerm_dns_zone" "adapter_emea_dev" {
  name                = "adapter.emea.dev.zum.cariad.digital"
  resource_group_name = data.azurerm_resource_group.manual.name
}

data "azurerm_dns_zone" "adapter_emea_staging" {
  name                = "adapter.emea.staging.azure.zum.cariad.digital"
  resource_group_name = data.azurerm_resource_group.manual.name
}

data "azurerm_dns_zone" "adapter_emea_prod" {
  name                = "adapter.emea.azure.zum.cariad.digital"
  resource_group_name = data.azurerm_resource_group.manual.name
}

data "azurerm_dns_zone" "adapter_nar_prod" {
  name                = "adapter.aoa.azure.zum.cariad.digital"
  resource_group_name = data.azurerm_resource_group.manual.name
}

resource "acme_certificate" "adapter_emea_dev" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = "*.${data.azurerm_dns_zone.adapter_emea_dev.name}"

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID     = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET = azuread_service_principal_password.dns_user.value
      #AZURE_CLIENT_ID       = "f5cc2d86-e0d0-4c52-8e69-9b596726ad08"
      #AZURE_CLIENT_SECRET   = "oB5XyqZ870X.V-uADl..348flTVuIx9Bt."
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
<<<<<<< Updated upstream
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.adapter_emea_dev.name
=======
      AZURE_SUBSCRIPTION_ID = "8a0c0950-8f30-4313-8f4a-7f934e6d8953"
      AZURE_TENANT_ID       = "a12a82ff-eb68-4d6d-b3c7-c4fb2d2220e5"  
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.audi-v2-emea-dev.name
      AZURE_ENVIRONMENT     = "china"
>>>>>>> Stashed changes
    }
  }

   depends_on = [azurerm_role_assignment.dns_user]
}

resource "acme_certificate" "adapter_emea_staging" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = "*.${data.azurerm_dns_zone.adapter_emea_staging.name}"

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET   = azuread_service_principal_password.dns_user.value
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.adapter_emea_staging.name
    }
  }

  depends_on = [azurerm_role_assignment.dns_user]
}

resource "acme_certificate" "adapter_emea_prod" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = "*.${data.azurerm_dns_zone.adapter_emea_prod.name}"

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = azuread_service_principal.dns_user.application_id
      AZURE_CLIENT_SECRET   = azuread_service_principal_password.dns_user.value
      AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.manual.name
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_ZONE_NAME       = data.azurerm_dns_zone.adapter_emea_prod.name
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
    }
  }

  depends_on = [azurerm_role_assignment.dns_user]
}
