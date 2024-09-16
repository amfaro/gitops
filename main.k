import manifests
import argo_cd.v1alpha1 as argocd

_env = option("env") or "local"
_secrets_provider = option("secrets_provider") or "op"
_ref = option("ref") or "HEAD"
_app = argocd.Application {
    kind = "Application"
    apiVersion = "argoproj.io/v1alpha1"
    metadata = {
        name = "argocd-${_env}-${_secrets_provider}"
        namespace = "argocd"
    }
    spec = {
        project = "default"
        source = {
            repoURL = "https://github.com/amfaro/gitops.git"
            targetRevision = _ref
            path = "applications"
            plugin = {name = "kcl-v1.0"}
        }
        destination = {
            server = "https://kubernetes.default.svc"
            namespace = "argocd"
        }
        syncPolicy = {
            automated = {
                prune = True
                selfHeal = True
            }
        }
    }
}

manifests.yaml_stream([_app])
