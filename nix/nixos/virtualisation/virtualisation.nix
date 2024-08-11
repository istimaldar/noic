{ config, ... }: {
  containers = import ./containers.nix { };
  libvirtd = import ./libvirtd.nix { };
  oci-containers = import ./oci-containers.nix { inherit config; };
  podman = import ./podman.nix { };

  lxd.enable = true;
  virtualbox.host.enable = true;
}
