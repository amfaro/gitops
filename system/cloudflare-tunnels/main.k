[{
    apiVersion = "apps/v1"
    kind = "Deployment"
    metadata = {
        labels = {app = "cloudflared"}
        name = "cloudflared-deployment"
        namespace = "cloudflare-operator-system"
    }
    spec = {
        replicas = 2
        selector = {
            matchLabels = {pod = "cloudflared"}
        }
        template = {
            metadata = {
                creationTimestamp = None
                labels = {pod = "cloudflared"}
            }
            spec = {containers = [{
                command = [
                    "cloudflared"
                    "tunnel"
                    "--metrics"
                    "0.0.0.0:2000"
                    "run"
                ]
                args = [
                    "--no-tls-verify"
                    "--token"
                    "$(CLOUDFLARE_TUNNEL_CREDENTIAL)"
                ]
                image = "cloudflare/cloudflared:latest"
                name = "cloudflared"
                livenessProbe = {
                    httpGet = {
                        path = "/ready"
                        port = 2000
                    }
                    failureThreshold = 1
                    initialDelaySeconds = 10
                    periodSeconds = 10
                }
                env = [{
                    name = "CLOUDFLARE_TUNNEL_CREDENTIAL"
                    valueFrom = {
                        secretKeyRef = {
                            name = "cloudflare-credentials"
                            key = "CLOUDFLARE_TUNNEL_CREDENTIAL_SECRET_LOCAL"
                        }
                    }
                }]
            }]}
        }
    }
}]
