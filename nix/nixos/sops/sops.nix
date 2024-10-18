{ ... }: {
  defaultSopsFile = ../../../secrets/secrets.yaml;
  age = {
    keyFile = "/var/lib/sops-nix/key.txt";
    generateKey = false;
  };
  secrets = {
    "kubernetes/cert_manager/token" = {};
    "cert-manager-acme-cloudflare.yaml" = {
      sopsFile = ../../../secrets/manifests.yaml;
      path = "/var/lib/rancher/k3s/server/manifests/cert-manager-acme-cloudflare.yaml";
    };
  };
}
