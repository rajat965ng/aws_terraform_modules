resource "kubernetes_namespace" "book_info" {
  depends_on = [helm_release.istiod]

  metadata {
    name = "book-info"
    labels = {
      istio-injection = "enabled"
    }
  }
  count = var.init_sample_app ? 1 : 0
}


/*
As most of this is general issues with Terraform v0.13, going to close it out. As @kam1kaze mentioned,
you need to specify the provider block in each module as it doesn't seem to inherit it.
*/

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.10.0"
    }
  }
}

provider "kubectl" {
  config_path = "kubeconfig"
}


data "kubectl_path_documents" "manifests" {
  pattern = "helm-charts/istio/bookInfo/*.yaml"
}

resource "kubectl_manifest" "manifests" {
  depends_on         = [kubernetes_namespace.book_info]
  count              = var.init_sample_app ? length(data.kubectl_path_documents.manifests.documents) : 0
  yaml_body          = element(data.kubectl_path_documents.manifests.documents, count.index)
  override_namespace = "book-info"
}