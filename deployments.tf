resource "kubernetes_deployment" "app" {
  for_each = {for app in local.apps : app.name => app}

  metadata {
    name = each.value.name
    labels = {
      app = each.value.name
    }
  }

  spec {
    replicas = each.value.replicas
    selector {
      match_labels = {
        app = each.value.name
      }
    }
    template {
      metadata {
        labels = {
          app = each.value.name
        }
      }
      spec {
        container {
          name = each.value.name
          image = each.value.image
          args = split(",", each.value.args)
          port {
            container_port = each.value.port
          }
        }
      }
    }
  }
}
