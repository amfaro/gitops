[
    {
        apiVersion = "external-secrets.io/v1beta1"
        kind = "ClusterSecretStore"
        metadata = {name = "cluster-secret-store"}
        spec = {
            provider = {
                onepassword = {
                    connectHost = "http://onepassword-connect.1password.svc.cluster.local:8080"
                    vaults = {k8s = 1}
                    auth = {
                        secretRef = {
                            connectTokenSecretRef = {
                                namespace = "1password"
                                name = "onepassword-token"
                                key = "token"
                            }
                        }
                    }
                }
            }
        }
    }
    {
        apiVersion = "external-secrets.io/v1beta1"
        kind = "ExternalSecret"
        metadata = {
            name = "cloudflare-credentials"
            namespace = "cloudflare-operator-system"
        }
        spec = {
            secretStoreRef = {
                kind = "ClusterSecretStore"
                name = "cluster-secret-store"
            }
            target = {creationPolicy = "Owner"}
            dataFrom = [{
                extract = {key = "cloudflare--3d"}
            }]
        }
    }
    {
        apiVersion = "external-secrets.io/v1beta1"
        kind = "ExternalSecret"
        metadata = {
            name = "harbor-credentials"
            namespace = "argo-workflows"
        }
        spec = {
            secretStoreRef = {
                kind = "ClusterSecretStore"
                name = "cluster-secret-store"
            }
            target = {creationPolicy = "Owner"}
            dataFrom = [{
                extract = {key = "harbor--gmatter"}
            }]
        }
    }
]
