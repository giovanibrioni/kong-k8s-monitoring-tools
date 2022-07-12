curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=httpbin-service' \
  --data 'url=http://httpbin-service.default.svc.cluster.local/'

curl -i -X POST \
  --url http://localhost/admin-api/services/httpbin-service/routes/ \
  --data 'hosts[]=httpbin.local' \
  --data name=httpbin-route

curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=foo-service' \
  --data 'url=http://foo-service.default.svc.cluster.local/'

curl -i -X POST \
  --url http://localhost/admin-api/services/foo-service/routes/ \
  --data 'paths[]=/foo' \
  --data name=foo-route

curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=bar-service' \
  --data 'url=http://bar-service.default.svc.cluster.local/'

curl -i -X POST \
  --url http://localhost/admin-api/services/bar-service/routes/ \
  --data 'paths[]=/bar' \
  --data name=bar-route