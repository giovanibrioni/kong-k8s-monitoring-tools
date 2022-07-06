helm repo add kong https://charts.konghq.com
helm repo update

helm install all-in-one kong/kong --namespace kong --create-namespace --set ingressController.installCRDs=false --values config/kong-values.yaml --version 2.8.0