resource "kubernetes_deployment" "ns-diary__backend" {

  metadata {
    name      = "backend"
    namespace = "ns-diary"
  }

  spec {
    replicas = 4
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "backend"
      }
    }
    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }

    template {
      metadata {
        annotations = {}
        labels      = { "app.kubernetes.io/name" = "backend" }
      }

      spec {

        restart_policy                   = "Always"
        share_process_namespace          = false
        termination_grace_period_seconds = 30

        container {
          image             = format("%s.dkr.ecr.%s.amazonaws.com/backend:nolb", data.aws_caller_identity.current.account_id, data.aws_region.current.name)
          image_pull_policy = "Always"
          name              = "backend"
          port {
            container_port = 8081
            protocol       = "TCP"
          }

          resources {
          }
        }
      }
    }
  }
}