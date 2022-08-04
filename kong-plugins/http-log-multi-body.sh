curl -i -X POST http://localhost/admin-api/plugins \
  --data name=http-log-multi-body \
  --data config.http_endpoint="http://audit-server-logstash.audit.svc.cluster.local:8080" \
  --data 'config.body_content_types[]=text/plain'