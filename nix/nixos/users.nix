{ pkgs, ... }:
{
  istimaldar = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "podman"
      "render"
      "video"
    ];
    shell = pkgs.zsh;
  };
}
