curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=keycloak-service' \
  --data 'url=http://keycloak-kong.keycloak.svc.cluster.local:8080/'

curl -i -X POST \
  --url http://localhost:8001/services/keycloak-service/routes/ \
  --data 'hosts[]=keycloak.local' \
  --data name=keycloak-route