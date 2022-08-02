helm repo add kong https://charts.konghq.com
helm repo update
helm upgrade --install cp kong/kong --namespace kong --create-namespace --values config/values-CP.yaml