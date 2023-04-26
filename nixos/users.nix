{ pkgs, ... }:
{
  istimaldar = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "podman"
    ];
    shell = pkgs.zsh;
  };
}
