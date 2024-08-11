{ ... }: {
  enable = true;
  onBoot = "start";
  allowedBridges = [
    "virbr0"
  ];
  nss = {
    enable = true;
    enableGuest = true;
  };
  qemu = {
    verbatimConfig = ''
      namespaces = []
      memory_backing_dir = "/dev/shm"
    '';
  };
}
