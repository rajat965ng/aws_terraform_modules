resource "kubernetes_namespace" "istio-ns" {

  metadata {
    name = "istio-system"
  }
}


resource "helm_release" "istio-base" {
  depends_on = [kubernetes_namespace.istio-ns]
  name       = "istio-base"
  chart      = "helm-charts/istio/manifests/charts/base"
  namespace  = kubernetes_namespace.istio-ns.metadata.0.name
}

resource "helm_release" "istiod" {
  depends_on = [helm_release.istio-base]
  name       = "istiod"
  chart      = "helm-charts/istio/manifests/charts/istio-control/istio-discovery"
  namespace  = kubernetes_namespace.istio-ns.metadata.0.name
}

resource "helm_release" "istio-ingress" {
  depends_on = [helm_release.istiod]
  name       = "istio-ingress"
  chart      = "helm-charts/istio/manifests/charts/gateways/istio-ingress"
  namespace  = kubernetes_namespace.istio-ns.metadata.0.name
}

data "kubernetes_service" "ingress-gateway" {

  metadata {
    name      = "istio-ingressgateway"
    namespace = kubernetes_namespace.istio-ns.metadata.0.name
  }
}
