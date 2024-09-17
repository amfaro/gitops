import manifests

manifests.yaml_stream(sum([
    [argo_workflows]
    [harbor]
    [cloudflare_tunnels]
    [external_secrets]
    [onepassword]
    [secret_stores]
    [test]
], []))
