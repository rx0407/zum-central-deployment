module "aks" {
  source                            = "Azure/aks/azurerm"
  version                           = "6.1.0"
  resource_group_name               = azurerm_resource_group.resource_group.name
  client_id                         = azuread_application.kubernetes.application_id
  client_secret                     = azuread_service_principal_password.k8s_user.value
  kubernetes_version                = "1.23.12"
  orchestrator_version              = "1.23.12"
  prefix                            = "zum"
  cluster_name                      = "zum-central-aks"
  network_plugin                    = "azure"
  vnet_subnet_id                    = module.vnet.vnet_subnets[1]
  os_disk_size_gb                   = 30
  sku_tier                          = "Paid" # defaults to Free
  role_based_access_control_enabled = false
  #rbac_aad_admin_group_object_ids  = [data.azuread_group.aks_cluster_admins.id]
  #rbac_aad_managed                 = true
  private_cluster_enabled          = false # default value, TODO: true when merged changes are released (module)
  http_application_routing_enabled = false
  azure_policy_enabled             = true
  enable_auto_scaling              = true
  agents_min_count                 = 2
  agents_max_count                 = 8
  agents_count                     = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                  = 30
  agents_pool_name                 = "exnodepool"
  agents_availability_zones        = ["1"]
  agents_type                      = "VirtualMachineScaleSets"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  ingress_application_gateway_enabled     = true
  ingress_application_gateway_name        = "aks-agw"
  ingress_application_gateway_subnet_cidr = "10.0.3.0/24"

  network_policy                 = "azure"
  net_profile_dns_service_ip     = "10.1.0.10"
  net_profile_docker_bridge_cidr = "170.1.0.1/16"
  net_profile_service_cidr       = "10.1.0.0/16"

  depends_on = [azurerm_resource_group.resource_group, module.vnet, azurerm_role_assignment.aks]
}
