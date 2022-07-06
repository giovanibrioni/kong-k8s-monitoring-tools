# kong k8s

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
sh config/install-metallb.sh
```

## Install kong

```bash
# Install kong
sh config/install-kong.sh

# Apply kind specific patches to forward the hostPorts to the ingress controller
kubectl patch deployment all-in-one-kong -n kong -p '{"spec":{"template":{"spec":{"containers":[{"name":"proxy","ports":[{"containerPort":8000,"hostPort":80,"name":"proxy","protocol":"TCP"},{"containerPort":8443,"hostPort":43,"name":"proxy-ssl","protocol":"TCP"}]}],"nodeSelector":{"ingress-ready":"true"},"tolerations":[{"key":"node-role.kubernetes.io/control-plane","operator":"Equal","effect":"NoSchedule"},{"key":"node-role.kubernetes.io/master","operator":"Equal","effect":"NoSchedule"}]}}}}'
```

```bash
# Deploy all Apps
kubectl apply -f apps --recursive
```
## Install Monitoring tools

```bash
# Install prometheus
sh config/install-prometheus.sh

# Install prometheus plugin
kubectl apply -f kong-plugins/prometheus.yaml

# Install grafana
sh config/install-grafana.sh
```

## Setup `/etc/hosts`

> /etc/hosts
```bash
127.0.0.1	httpbin.local
127.0.0.1	grafana.local
127.0.0.1	prometheus.local
```

## Services URLs

- [httpbin](https://httpbin.local)
- [prometheus](https://prometheus.local)
- [grafana](https://grafana.local)
    - Username: `admin`
    - Password: `kong`


## Generate load

```bash
sh load-test.sh
```

## Apply rate-limiting plugin

```bash
kubectl apply kong-plugins/rate-limiting.yaml
```

## Author

Managed by [Giovani Brioni Nunes](https://github.com/giovanibrioni)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/giovanibrioni/kong-k8s/blob/master/LICENSE) for full details.