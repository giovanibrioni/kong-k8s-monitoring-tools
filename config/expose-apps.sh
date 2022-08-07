curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=httpbin-service' \
  --data 'url=http://httpbin-service.default.svc.cluster.local/'

curl -i -X POST \
  --url http://localhost/admin-api/services/httpbin-service/routes/ \
  --data 'hosts[]=httpbin.local' \
  --data name=httpbin-route
