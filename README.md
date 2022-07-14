# Kong API Gateway on K8s - Ingress Mode

This is a how to guide to configure Kong API Gateway running on k8s as Ingress controller with monitoring tools (Prometheus, Grafana and ELk)  
 - To configure Kong OSS running in hybrid mode switch to branch: kong-hybrid-mode
 - To configure Kong Enterprise Free running in hybrid mode switch to branch: enterprise-free-hybrid

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
# Install kong
sh config/install-kong.sh
```

```bash
# Deploy all Apps
kubectl apply -f apps --recursive
```
## Install Monitoring tools

```bash
# Install prometheus
sh resources/prometheus/install-prometheus.sh

# Apply prometheus plugin
kubectl apply -f kong-plugins/prometheus.yaml

# Install grafana
sh resources/grafana/install-grafana.sh

# Install Elastic Stack
sh resources/elk/install-elk.sh

# Apply tcp-log plugin
kubectl apply -f kong-plugins/tcp-log.yaml
```

## Setup `/etc/hosts`

> /etc/hosts
```bash
127.0.0.1	httpbin.local
127.0.0.1	grafana.local
127.0.0.1	prometheus.local
127.0.0.1   kibana.local
```

## Services URLs

- [httpbin](http://httpbin.local)
- [prometheus](http://prometheus.local)
- [kibana](http://kibana.local)
- [grafana](http://grafana.local)
    - Username: `admin`
    - Password: `kong`


## Generate load

```bash
sh load-test.sh
```

## Apply rate-limiting plugin

```bash
kubectl apply -f kong-plugins/rate-limiting.yaml
```
## Cleanup Kind

```bash
kind delete cluster --name kong
```

## Author

Managed by [Giovani Brioni Nunes](https://github.com/giovanibrioni)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/giovanibrioni/kong-k8s/blob/master/LICENSE) for full details.