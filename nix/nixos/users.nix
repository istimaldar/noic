{ host, pkgs, ... }:
{
  istimaldar = {
    isNormalUser = true;
    extraGroups = [
      "qemu-libvirtd"
      "libvirtd"
      "wheel"
      "podman"
      "render"
      "video"
      "networkmanagerF"
    ];
    shell = pkgs.zsh;
  };
}
