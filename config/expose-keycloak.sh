curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=keycloak-service' \
  --data 'url=http://keycloak-kong.keycloak.svc.cluster.local:8080/'

curl -i -X POST \
  --url http://localhost/admin-api/services/keycloak-service/routes/ \
  --data 'hosts[]=keycloak.local' \
  --data name=keycloak-route