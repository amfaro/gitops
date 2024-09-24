{
    apiVersion = "argoproj.io/v1alpha1"
    kind = "Application"
    metadata = {
        name = "nocodb"
        namespace = "argocd"
    }
    spec = {
        project = "default"
        source = {
            repoURL = "https://github.com/nocodb/nocodb.git"
            targetRevision = "develop"
            path = "charts/nocodb"
            helm = {valueFiles = ["values.yaml"]}
        }
        destination = {
            server = "https://kubernetes.default.svc"
            namespace = "nocodb"
        }
        syncPolicy = {
            automated = {
                prune = True
                selfHeal = True
            }
            syncOptions = ["CreateNamespace=true"]
        }
    }
}
