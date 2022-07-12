curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=grafana-service' \
  --data 'url=http://grafana-kong.monitoring.svc.cluster.local:80/'

curl -i -X POST \
  --url http://localhost/admin-api/services/grafana-service/routes/ \
  --data 'hosts[]=grafana.local' \
  --data 'preserve_host=true' \
  --data 'strip_path=false' \
  --data name=grafana-route

curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=kibana-service' \
  --data 'url=http://kibana-kibana.elk.svc.cluster.local:5601/'

curl -i -X POST \
  --url http://localhost/admin-api/services/kibana-service/routes/ \
  --data 'hosts[]=kibana.local' \
  --data 'paths[]=/' \
  --data name=kibana-route

curl -i -X POST \
  --url http://localhost/admin-api/services/ \
  --data 'name=prometheus-service' \
  --data 'url=http://prometheus-kong-server.monitoring.svc.cluster.local:80/'

curl -i -X POST \
  --url http://localhost/admin-api/services/prometheus-service/routes/ \
  --data 'hosts[]=prometheus.local' \
  --data 'paths[]=/' \
  --data name=prometheus-route