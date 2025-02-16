resource "kubernetes_service" "app" {
  for_each = { for app in local.apps : app.name => app}
  metadata {
    name = each.value.name
  }
  spec {
    selector = {
      app = each.value.name
    }
    port {
      port = each.value.port
      target_port = each.value.port
    }
  }
}
