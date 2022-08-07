# Kong API Gateway on K8s - Enterprise Free - Hybrid Mode

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

## Generate Certificates
Hybrid mode uses TLS to secure the CP/DP node communication channel, and requires certificates for it. You can generate these either using kong hybrid gen_cert on a local Kong installation or using OpenSSL:
```bash
openssl req -new -x509 -nodes -newkey ec:<(openssl ecparam -name secp384r1) \
  -keyout /tmp/cluster.key -out /tmp/cluster.crt \
  -days 1095 -subj "/CN=kong_clustering"
```

## Place these certificates in a Secret
```bash
kubectl create namespace kong
kubectl create secret tls kong-cluster-cert --cert=/tmp/cluster.crt --key=/tmp/cluster.key -n kong
```
## Configure RBAC to enable Kong Manager
```bash
sh config/rbac.sh
```
## Install kong

```bash
# Install kong control plane
sh config/install-kong-cp.sh

# Install kong data plane
sh config/install-kong-dp.sh
```
## Deploy all Apps
```bash
kubectl apply -f apps --recursive
```

## Expose kong admin API and Apps
```bash
# Port forward kong admin
kubectl port-forward -n kong service/cp-kong-admin 8001:8001

# Expose admin API
sh config/expose-admin-api.sh

# Expose Kong Manager GUI
sh config/expose-manager.sh

# Expose Apps
sh config/expose-apps.sh
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
127.0.0.1   kong-manager.local
```

## Services URLs

- [httpbin](http://httpbin.local)
- [kong-manager GUI](http://kong-manager.local)
- [prometheus](http://prometheus.local)
- [kibana](http://kibana.local)
- [grafana](http://grafana.local)
    - Username: `admin`
    - Password: `kong`


## Generate load

```bash
sh load-test.sh
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