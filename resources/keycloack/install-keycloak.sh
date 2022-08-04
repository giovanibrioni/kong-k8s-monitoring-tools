  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm install keycloak-kong bitnami/keycloak --namespace keycloak --create-namespace --values resources/keycloak/keycloak-values.yaml