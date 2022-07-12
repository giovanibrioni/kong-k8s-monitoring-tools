curl -i -X POST http://localhost/admin-api/plugins \
  --data name=tcp-log \
  --data config.host=logstash-logstash.elk.svc.cluster.local \
  --data config.port=1514