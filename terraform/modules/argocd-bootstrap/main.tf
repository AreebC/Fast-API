resource "kubernetes_manifest" "root_application" {
  manifest = yamldecode(
    file("${path.module}/root-application.yaml")
  )
}