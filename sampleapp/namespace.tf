resource "kubernetes_namespace" "ns-diary" {
  metadata {
    name = "ns-diary"
  }

  timeouts {
    delete = "20m"
  }
}