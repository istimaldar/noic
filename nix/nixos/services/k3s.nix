{ host, ... }: {
  enable = host.features.kubernetes.enable;
  role = "server";
  extraFlags = [
    "--disable=traefik,metrics-server"
  ];
  manifests = {
    argocd = {
      enable = true;
      target = "argocd.yaml";
      content = import ./charts/argocd.nix { inherit host; };
    };
  };
}
