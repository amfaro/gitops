import argo_cd.v1alpha1 as argocd

onepassword = argocd.Application {
    apiVersion = "argoproj.io/v1alpha1"
    kind = "Application"
    metadata = {
        name = "onepassword-connect"
        namespace = "argocd"
        annotations = {"argocd.argoproj.io/sync-wave" = "0"}
    }
    spec = {
        project = "default"
        source = {
            repoURL = "https://1password.github.io/connect-helm-charts"
            targetRevision = "1.15.1"
            chart = "connect"
            helm = {parameters = [
                {
                    name = "operator.create"
                    value = "true"
                }
                {
                    name = "connect.create"
                    value = "true"
                }
            ]}
        }
        destination = {
            server = "https://kubernetes.default.svc"
            namespace = "1password"
        }
        syncPolicy = {
            syncOptions = ["CreateNamespace=true"]
            automated = {
                prune = True
                selfHeal = True
            }
        }
    }
}

