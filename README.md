# Helm charts

Add the repository:

```console
helm repo add mihudec https://mihudec.github.io/helm
helm repo update
```

## Vector

```console
helm install vector mihudec/vector
```

## Telegraf

The Telegraf chart expects an existing ConfigMap containing a
`telegraf.conf` key. It does not generate the main Telegraf configuration.

```console
kubectl apply -f examples/telegraf-configmap.yaml
helm install telegraf mihudec/telegraf
```
