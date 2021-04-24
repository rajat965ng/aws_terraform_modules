output "ingress_ip" {
  value = "${module.service-mesh.ingress_ip}"
}

output "kubeconfig" {
  value     = "\n ${module.eks.kubeconfig}"
  sensitive = true
}
