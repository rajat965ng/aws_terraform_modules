resource "local_file" "kubeconfig" {
  content              = local.kubeconfig
  filename             = "kubeconfig"
  file_permission      = "0644"
  directory_permission = "0755"
}
