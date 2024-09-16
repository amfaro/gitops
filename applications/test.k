import k8s.api.core.v1 as k8s
import manifests

_namespace = k8s.Namespace {
    apiVersion = "v1"
    kind = "Namespace"
    metadata = {name = "test"}
}

manifests.yaml_stream([_namespace])
