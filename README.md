# Kong API Gateway on K8s - Hybrid Mode

## Dependencies

- [Docker](https://docs.docker.com/engine/install/)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm v3](https://helm.sh/docs/intro/install/)


#### Install kubectl and helm using asdf

```bash
asdf plugin add kubectl
asdf plugin add helm
asdf install
```

## Create Kind cluster

```bash
kind create cluster --name kong --config=resources/kind.yaml
kind get kubeconfig --name kong > ~/.kube/kind-kong-config
```

## Setup kubectl

```bash
# Setup kubeconfig
export KUBECONFIG=~/.kube/kind-kong-config

# Testing configuration
kubectl get nodes
```

## Install LoadBalancer(metallb)

```bash
# Install metallb
sh resources/metallb/install-metallb.sh
```

## Install kong

```bash
# Install kong stantalone(admin and proxy on same pod)
sh config/install-kong-db.sh
```

## Expose kong admin API
```bash
# Port forward kong admin
kubectl port-forward -n kong service/gateway-kong-admin 8001:8001

# Expose admin API
sh config/expose-admin-api.sh
```

## Install Monitoring tools

```bash
# Install prometheus
sh resources/prometheus/install-prometheus.sh

# Apply prometheus plugin
sh kong-plugins/prometheus.sh

# Install grafana
sh resources/grafana/install-grafana.sh

# Install Elastic Stack
sh resources/elk/install-elk.sh

# Apply tcp-log plugin
sh kong-plugins/tcp-log.sh

# Expose grafana and kibana via kong
sh config/expose-monitoring-toos.sh
```

## Setup `/etc/hosts`

> /etc/hosts
```bash
127.0.0.1   httpbin.local
127.0.0.1   grafana.local
127.0.0.1   prometheus.local
127.0.0.1   kibana.local
127.0.0.1   keycloak.local
```

## Services URLs

- [httpbin](http://httpbin.local)
- [prometheus](http://prometheus.local)
- [kibana](http://kibana.local)
- [grafana](http://grafana.local)
    - Username: `admin`
    - Password: `kong`


## OpenAPI Specification to Kong

```bash
# change --kong-addr on file config/openapi2kong/convert-and-deploy.sh to your kong admin api url (its must be acessed from docker container)

# Convert OpenAPI Specification to Kong declarative config and deploy
sh config/openapi2kong/convert-and-deploy.sh
```

## Protect API with keycloak

```bash
# Configure kong route to expose keycloak.local
sh config/expose-keycloak.sh
```
### Follow this steps to configure keycloak
https://github.com/giovanibrioni/kong-k8s-monitoring-tools#install-keycloak

### Apply oidc plugin on httpbin-service
```bash
sh kong-plugins/oidc.sh 
```

### Follow this steps to test
https://github.com/giovanibrioni/kong-k8s-monitoring-tools#test

## Configure Autid Log

```bash
# Deploy Audit Server to store request and response body on ElasticSearch (Dependency: Elk resources)
sh resources/elk/install-audit-server.sh

# Apply kong-plugin to send data to Audit Server
sh kong-plugins/http-log-multi-body.sh 
```

```bash
# This request should send data with body to ElasticSearch
curl -H "Host:httpbin.local" -X POST http://localhost/anything -d "hello=world"
```

```bash
# This don't send audit log with body to ElasticSearch
curl -H "Host:httpbin.local" http://localhost/anything
```
## Generate load

```bash
sh generate-load.sh
```

## Apply rate-limiting plugin to stop load

```bash
sh kong-plugins/rate-limiting.sh
```
## Cleanup Kind

```bash
kind delete cluster --name kong
```

## Author

Managed by [Giovani Brioni Nunes](https://github.com/giovanibrioni)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/giovanibrioni/kong-k8s/blob/master/LICENSE) for full details.