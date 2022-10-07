curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=kong-admin-service' \
  --data 'url=http://gateway-kong-admin.kong.svc.cluster.local:8001/'

curl -i -X POST \
  --url http://localhost:8001/services/kong-admin-service/routes/ \
  --data 'paths[]=/admin-api' \
  --data name=kong-admin-route
