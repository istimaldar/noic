{ host, ... }: {
  enable = host.features.kubernetes.enable;
  role = "server";

}
