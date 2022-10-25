resource "kubernetes_service" "ns-diary__service-frontend" {

  metadata {
    name      = "frontend"
    namespace = "ns-diary"
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "frontend"
    }

    type = "NodePort"
    port {
      port        = 80
      protocol    = "TCP"
      target_port = "35001"
    }
  }

}