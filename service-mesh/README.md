# Service Mesh [Istio]

## Configure kubectl and helm to use service mesh.

[Configure kubeconfig]
- export KUBECONFIG=kubeconfig:~/.kube/config
- kubectl config view --merge --flatten >> ~/.kube/config

[Configure kubectl]
- kubectl config get-contexts
- kubectl config use-context <name>

