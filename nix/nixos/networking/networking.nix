{ host, ... }: {
  hostName = host.name;
  networkmanager = {
    enable = true;
    dns = "default";
    wifi = {
      scanRandMacAddress = false;
      powersave = false;
      backend = "iwd";
    };
  };
  nameservers = [
    "1.1.1.1"
  ];
  firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        3000
        6443
      ];
      allowedUDPPorts = [
        8472
      ];
  };
}
