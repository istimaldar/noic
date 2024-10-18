{ ... }: {
  defaultSopsFile = ../../../secrets/secrets.yaml;
  age = {
    keyFile = "/var/lib/sops-nix/key.txt";
    generateKey = false;
  };
  secrets = {
    "kubernetes/cert_manager/token" = {};
  };
}
