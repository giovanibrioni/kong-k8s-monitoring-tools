helm repo add metallb https://metallb.github.io/metallb
helm repo update
helm install metallb metallb/metallb --namespace metallb --create-namespace -f resources/metallb/metallb-values.yaml --version 0.12.1