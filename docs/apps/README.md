# Manage K8s Apps

## Tasks

### install-argocd

```bash
kubectl create namespace argocd
kubectl apply \
  --namespace argocd \
  --filename https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### apply-kcl-patch

```bash
kubectl apply --filename ./kcl-cmp.yaml
kubectl patch deploy/argocd-repo-server \
  --namespace argocd \
  --patch "$(cat ./patch-argocd-repo-server.yaml)"
```

### cli-login-argocd

```bash
argocd login localhost:8080 \
  --username admin \
  --insecure \
  --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
```

### port-forward-argocd

```bash
kubectl port-forward svc/argocd-server \
  --namespace argocd 8080:443
```

### extract-password-argocd

```bash
pass=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo $pass | pbcopy
```

### launch-web-argocd

```bash
open https://localhost:8080
```
