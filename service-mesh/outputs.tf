locals {
  ingress_ip = data.kubernetes_service.ingress-gateway.status.0.load_balancer.0.ingress.0.hostname
}

output "ingress_ip" {
  value = "${local.ingress_ip}"
}
