helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana-kong grafana/grafana --namespace monitoring --create-namespace --set adminPassword=kong --values config/grafana-values.yaml --version 6.28.0