helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus-kong prometheus-community/prometheus --namespace monitoring --create-namespace --values config/prometheus-values.yaml --version 15.8.5