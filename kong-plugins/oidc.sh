curl -i -X POST http://localhost/admin-api/services/httpbin-service/plugins \
  --data name=oidc \
  --data config.client_id="kong" \
  --data config.client_secret="your-client-secret" \
  --data config.bearer_only="yes" \
  --data config.realm="kong" \
  --data config.introspection_endpoint="http://keycloak.local/realms/kong/protocol/openid-connect/token/introspect" \
  --data config.discovery="http://keycloack.local/auth/realms/kong/.well-known/openid-configuration"  \
  --data config.scope="openid"