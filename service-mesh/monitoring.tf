resource "helm_release" "prometheus" {
  count             = var.enable_monitoring ? 1 : 0
  dependency_update = true
  name              = "prometheus"
  chart             = "helm-charts/prometheus"
  namespace         = kubernetes_namespace.istio-ns.metadata.0.name
}




resource "helm_release" "grafana" {
  count             = var.enable_monitoring ? 1 : 0
  dependency_update = true
  depends_on        = [helm_release.prometheus]
  name              = "grafana"
  chart             = "helm-charts/grafana"
  namespace         = kubernetes_namespace.istio-ns.metadata.0.name

  set {
    name  = "env.GF_SERVER_DOMAIN"
    value = local.ingress_ip
  }


  set {
    name  = "env.GF_SERVER_ROOT_URL"
    value = "https://${local.ingress_ip}/grafana"
  }


  set {
    name  = "env.GF_SERVER_SERVE_FROM_SUB_PATH"
    value = "true"
  }
}
