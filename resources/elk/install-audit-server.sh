helm repo add elastic https://helm.elastic.co
helm repo update
helm upgrade --install --values resources/elk/elasticsearch-values.yaml helm-es-kind elastic/elasticsearch --namespace=elk --create-namespace
helm upgrade --install kibana elastic/kibana -f resources/elk/kibana-values.yaml --namespace=elk  --create-namespace
helm upgrade --install audit-server elastic/logstash --namespace audit --create-namespace --values resources/elk/logstash-audit-values.yaml --version 7.17.3