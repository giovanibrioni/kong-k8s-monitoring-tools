helm repo add kong https://charts.konghq.com
helm repo update
helm install gateway kong/kong --namespace kong --create-namespace --values config/values-DP.yaml