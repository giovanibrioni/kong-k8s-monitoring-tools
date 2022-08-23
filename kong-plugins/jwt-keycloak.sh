curl -i -X POST http://localhost/admin-api/services/httpbin-service/plugins \
  --data name=jwt-keycloak \
  --data config.allowed_iss="http://keycloak-kong.keycloak.svc.cluster.local:8080/realms/kong"