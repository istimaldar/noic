{ host, ... }: {
  inherit (host.features.kubernetes) enable;
  role = "server";
  extraFlags = [
    "--disable=traefik"
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
      content = import ./manifests/system-applications.nix { inherit host; };
    };
  };
}
