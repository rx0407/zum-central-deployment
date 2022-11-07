resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "kubernetes_secret" "argocd" {
  metadata {
    name      = "argocd-server-tls"
    namespace = "argocd"
  }

  data = {
    "tls.crt" = acme_certificate.certificate.certificate_pem
    "tls.key" = acme_certificate.certificate.private_key_pem
  }

  type = "kubernetes.io/tls"

  depends_on = [kubernetes_namespace.argocd]
}

# resource "helm_release" "argocd" {
#   name       = "argocd"
#   chart      = "${path.module}/argocd"
#   namespace  = "argocd"
#   timeout    = "1200"
#   depends_on = [kubernetes_namespace.argocd]
# }
