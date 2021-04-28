resource "kubernetes_namespace" "logging" {

  metadata {
    name = "logging"
  }
  count = var.enable_logging ? 1 : 0
}


resource "helm_release" "elasticsearch" {
  count             = var.enable_logging ? 1 : 0
  dependency_update = true
  name              = "elasticsearch"
  chart             = "helm-charts/elasticsearch"
  namespace         = kubernetes_namespace.logging.metadata.0.name
}

resource "helm_release" "logstash" {
  count             = var.enable_logging ? 1 : 0
  dependency_update = true
  name              = "logstash"
  chart             = "helm-charts/logstash"
  namespace         = kubernetes_namespace.logging.metadata.0.name
  depends_on        = [helm_release.elasticsearch]
}
