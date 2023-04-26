{ config, pkgs, ... }:
{
  home = {
    username = "istimaldar";
    homeDirectory = "/home/istimaldar";
    packages = import ./common/packages.nix pkgs;
    file = import ./common/files.nix pkgs;
    stateVersion = "22.11";
  };

  programs = import ./common/programs.nix pkgs;

  services = import ./common/services.nix pkgs;

  fonts.fontconfig.enable = true;
}
