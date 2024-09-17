import argo_cd.v1alpha1 as argocd

harbor = argocd.Application {
    apiVersion = "argoproj.io/v1alpha1"
    kind = "Application"
    metadata = {
        name = "harbor"
        namespace = "argocd"
        annotations = {"argocd.argoproj.io/sync-wave" = "0"}
    }
    spec = {
        project = "default"
        source = {
            chart = "harbor"
            repoURL = "https://helm.goharbor.io"
            targetRevision = "1.15.1"
            helm = {values = """
                  expose:
                    type: clusterIP
                    tls:
                      enabled: false
                    ingress:
                      enabled: false
                  externalURL: https://harbor.jallen7usa.com
                """}
        }
        destination = {
            server = "https://kubernetes.default.svc"
            namespace = "harbor"
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

