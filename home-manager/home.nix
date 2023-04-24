{ config, pkgs, ... }:
{
  home = {
    username = "istimaldar";
    homeDirectory = "/home/istimaldar";
    stateVersion = "22.11";
  };
  fonts.fontconfig.enable = true;
}
