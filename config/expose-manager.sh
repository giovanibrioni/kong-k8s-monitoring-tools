curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=kong-manager-service' \
  --data 'url=http://cp-kong-manager.kong.svc.cluster.local:8002/'

curl -i -X POST \
  --url http://localhost/admin-api/services/kong-manager-service/routes/ \
  --data 'hosts[]=kong-manager.local' \
  --data name=kong-manager-route
