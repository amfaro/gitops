import argo_cd.v1alpha1 as argocd

secret_stores = argocd.Application {
    apiVersion = "argoproj.io/v1alpha1"
    kind = "Application"
    metadata = {
        name = "secret-stores"
        namespace = "argocd"
        annotations = {"argocd.argoproj.io/sync-wave" = "2"}
    }
    spec = {
        project = "default"
        source = {
            repoURL = "https://github.com/amfaro/gitops.git"
            targetRevision = "HEAD"
            path = "system/secret-stores.k"
            plugin = {name = "kcl-v1.0"}
        }
        destination = {
            server = "https://kubernetes.default.svc"
            namespace = "cloudflare-operator-system"
        }
        syncPolicy = {
            automated = {
                prune = True
                selfHeal = True
            }
        }
    }
}

