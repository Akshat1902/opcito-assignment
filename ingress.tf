resource "kubernetes_ingress_v1" "canary-ingress" {
  for_each = {for app in local.apps : app.name => app}

  metadata {
    name = "${each.value.name}-ingress"
    annotations = each.value.primary ? {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    } : {
      "nginx.ingress.kubernetes.io/rewrite-target"    = "/"
      "nginx.ingress.kubernetes.io/canary"              = "true"
      "nginx.ingress.kubernetes.io/canary-weight"       = each.value.traffic_weight
    }
  }
  spec {
    rule {
      host = "opcito-assignment.com"
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = each.value.name
              port {
                number = each.value.port
              }
            }
          }
        }
      }
    }
  }
}
