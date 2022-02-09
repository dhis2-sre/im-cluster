# Getting started

Run the below command to instantiate a cluster

```sh
make cluster
```

After successful completion the Kubernetes configuration file is created under the name `k3s.yaml`.

Run the below command to export `KUBECONFIG`

```sh
export KUBECONFIG=$(PWD)/k3s.yaml
```

Run the below command to show the cluster nodes

```sh
kubectl get nodes
```
