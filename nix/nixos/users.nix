{ pkgs, ... }:
{
  istimaldar = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "podman"
      "render"
      "video"
      "networkmanagerF"
    ];
    shell = pkgs.zsh;
  };
}
