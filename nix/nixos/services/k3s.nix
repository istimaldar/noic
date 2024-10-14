{ host, ... }: {
  enable = host.features.kubernetes.enable;
  role = "server";
  extraFlags = [
    "--disable=traefik,metrics-server"
  ];
}
