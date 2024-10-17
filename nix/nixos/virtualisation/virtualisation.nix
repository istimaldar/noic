{ config, lib, host, ... }: {
  containers = import ./containers.nix { };
  libvirtd = import ./libvirtd.nix { };
  oci-containers = import ./oci-containers.nix { inherit config lib host; };
  podman = import ./podman.nix { };

  lxd.enable = true;
  virtualbox.host.enable = true;
}
