helm repo add elastic https://helm.elastic.co
helm repo update
helm upgrade --install --values resources/elk/elasticsearch-values.yaml helm-es-kind elastic/elasticsearch --namespace=elk --create-namespace
helm install kibana elastic/kibana -f resources/elk/kibana-values.yaml --namespace=elk  --create-namespace
helm install logstash elastic/logstash --namespace elk --create-namespace --values resources/elk/logstash-values.yaml --version 7.17.3