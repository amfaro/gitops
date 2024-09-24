import manifests

manifests.yaml_stream(sum([
    [argo_workflows]
    [harbor]
    [cloudflare_tunnels]
    [external_secrets]
    [nocodb]
    [onepassword]
    [secret_stores]
    [test]
], []))
