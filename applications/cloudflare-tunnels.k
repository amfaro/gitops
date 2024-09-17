import argo_cd.v1alpha1 as argocd
import k8s.api.core.v1 as k8s

cloudflare_tunnels = [
    k8s.Namespace {
        kind = "Namespace"
        apiVersion = "v1"
        metadata = {name = "cloudflare-operator-system"}
    }
    argocd.Application {
        apiVersion = "argoproj.io/v1alpha1"
        kind = "Application"
        metadata = {
            name = "cloudflare-tunnels"
            namespace = "argocd"
            annotations = {"argocd.argoproj.io/sync-wave" = "2"}
        }
        spec = {
            project = "default"
            source = {
                repoURL = "https://github.com/amfaro/gitops.git"
                targetRevision = "HEAD"
                path = "system/cloudflare-tunnels"
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
]
