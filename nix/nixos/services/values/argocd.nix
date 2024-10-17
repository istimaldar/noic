{ host, ... }: {
  config.params = {
    "server.insecure" = true;
  };
  extraObjects = [
    builtins.toJSON (import ./application.nix { inherit host; })
  ];
}
