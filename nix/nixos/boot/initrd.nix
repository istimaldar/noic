_: {
  systemd.enable = true;
  luks.devices = {
    root = {
      device = "/dev/disk/by-label/nix-root";
      preLVM = true;
    };
  };
}
