{ pkgs, ... }:
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBYxsZ0H7rZSRki1OW6oKo9zbr4yrqQ8EMwbpvIBCSrn istimaldar"
    ];
  };
}
