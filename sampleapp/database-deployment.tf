resource "kubernetes_deployment" "ns-diary__database" {

  metadata {
    name      = "database"
    namespace = "ns-diary"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "database"
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
        labels      = { "app.kubernetes.io/name" = "database" }
      }

      spec {

        restart_policy                   = "Always"
        share_process_namespace          = false
        termination_grace_period_seconds = 30

        container {
          env {
            name  = "MYSQL_DATABASE"
            value = "DOCKERTEST"
          }
          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "qwerty1234"
          }

          image             = format("%s.dkr.ecr.%s.amazonaws.com/mariadb:10.9", data.aws_caller_identity.current.account_id, data.aws_region.current.name)
          image_pull_policy = "Always"
          name              = "database"
          port {
            container_port = 3306
            protocol       = "TCP"
          }

          resources {}

          # volume_mount {
          #   mount_path = "/var/lib/mysql"
          #   name       = "db-pvc"
          # }
        }
        # volume {
        #   name = "db-pvc"
        #   persistent_volume_claim {
        #     claim_name = "${kubernetes_persistent_volume_claim.ns-diary__pvc-diary.metadata.0.name}"
        #   }
        # }
      }
    }
  }
}