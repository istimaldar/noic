{ config, pkgs, host, ... }:
{
  home = {
    username = "istimaldar";
    homeDirectory = "/home/istimaldar";
    packages = import ./common/packages.nix pkgs;
    file = import ./common/files.nix { inherit pkgs host; };
    sessionVariables = import ./common/variables.nix pkgs;
    stateVersion = "22.11";
  };

  systemd.user.services = {
    mitmproxy = {
      Unit = {
        Description = "A free and open source interactive HTTPS proxy";
      };

      Service = {
        ExecStart = "${pkgs.mitmproxy}/bin/mitmweb";
      };    
    };
  };

  programs = import ./common/programs.nix { inherit pkgs host; };

  services = import ./common/services.nix pkgs;

  fonts.fontconfig.enable = true;
}
