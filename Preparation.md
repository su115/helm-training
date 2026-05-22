```sh
alias k='kubectl'
source <(kubectl completion bash)
complete -F __start_kubectl k

kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

# MetalLB
helm repo add metallb https://metallb.github.io/metallb
helm repo update

kubectl create namespace metallb-system
helm upgrade --install metallb metallb/metallb \
  --namespace metallb-system \
  --version 0.16.0 \              
  -f metalLB/values-metallb.yaml

kubectl apply -f metalLB/ip-pool.yaml 

# Ingress
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
kubectl create namespace ingress-ns
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-ns




```
