terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    acme = {
      source = "vancluever/acme"
    }
  }

  backend "azurerm" {
    resource_group_name  = "test-ray-rg"
    storage_account_name = "raysa20220818"
    container_name       = "zum-central-deployment"
    key                  = "terraform.tfstate"
<<<<<<< Updated upstream
=======
    subscription_id      = "b21f2bf7-0dba-4e93-b131-3de1b574d809"
    tenant_id            = "a12a82ff-eb68-4d6d-b3c7-c4fb2d2220e5"
>>>>>>> Stashed changes
  }
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "azurerm" {
  features {}

<<<<<<< Updated upstream
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "azuread" {
  tenant_id = var.tenant_id
=======
  subscription_id = "8a0c0950-8f30-4313-8f4a-7f934e6d8953"
  tenant_id       = "a12a82ff-eb68-4d6d-b3c7-c4fb2d2220e5"
}

provider "azuread" {
  tenant_id = "a12a82ff-eb68-4d6d-b3c7-c4fb2d2220e5"
>>>>>>> Stashed changes
}

provider "kubernetes" {
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_resource_group" "manual" {
  name = "zum-manual"
}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}


data "azuread_client_config" "current" {}