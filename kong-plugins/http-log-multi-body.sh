curl -i -X POST http://localhost/admin-api/services/httpbin-service/plugins \
  --data name=http-log-multi-body \
  --data config.http_endpoint="http://audit-server-logstash.audit.svc.cluster.local:8080"