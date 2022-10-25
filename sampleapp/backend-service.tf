resource "kubernetes_service" "ns-diary__service-backend" {

  metadata {
    name      = "backend"
    namespace = "ns-diary"
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "backend"
    }

    type = "ClusterIP"
    port {
      port        = 8081
      protocol    = "TCP"
      target_port = "8081"
    }
  }

}