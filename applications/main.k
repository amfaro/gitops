import manifests

manifests.yaml_stream(sum([
    [harbor]
    # [cloudflare_tunnels]
    [external_secrets]
    [onepassword]
    [secret_stores]
    [test]
], []))
