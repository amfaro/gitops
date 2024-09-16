import k8s.api.core.v1 as k8s

test = k8s.Namespace {
    apiVersion = "v1"
    kind = "Namespace"
    metadata = {name = "test"}
}

