data "azuread_group" "developers" {
  #display_name = "${data.azurerm_subscription.primary.display_name}-Contributors"
  display_name = "CTC41-ZUM-Contributor"
}

resource "azuread_application" "kubernetes" {
  display_name = "${var.resource_group_name}-kubernetes"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "k8s_user" {
  application_id               = azuread_application.kubernetes.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "k8s_user" {
  service_principal_id = azuread_service_principal.k8s_user.object_id
}

resource "azurerm_role_assignment" "aks" {
  principal_id         = azuread_service_principal.k8s_user.object_id
  role_definition_name = "Owner"
  scope                = data.azurerm_subscription.primary.id
}

resource "azuread_application" "dns_user" {
  display_name = "${var.resource_group_name}-dns"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "dns_user" {
  application_id               = azuread_application.dns_user.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "dns_user" {
  service_principal_id = azuread_service_principal.dns_user.object_id
}

resource "azurerm_role_assignment" "dns_user" {
  principal_id         = azuread_service_principal.dns_user.object_id
  role_definition_name = "Owner"
  scope                = data.azurerm_subscription.primary.id
}
