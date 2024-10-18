{ pkgs, host, ... }: {
  enable = host.features.kubernetes.enable;
  package = pkgs.k3s_1_29;
  role = "server";
  extraFlags = [
    "--disable=traefik,metrics-server"
  ];
  manifests = {
    argocd = {
      enable = true;
      target = "argocd.yaml";
      content = import ./manifests/argocd.nix { };
    };
    system-applications = {
      enable = true;
      target = "system-applications.yaml";
      content = import ./manifests/system-applications.nix { };
    };
  };
}
