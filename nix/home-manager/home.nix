{ lib, config, pkgs, host, ... }:
{
  home = {
    username = "istimaldar";
    homeDirectory = "/home/istimaldar";
    packages = import ./common/packages.nix { inherit pkgs host; };
    file = import ./common/files.nix { inherit pkgs host; };
    sessionVariables = import ./common/variables.nix pkgs;
    pointerCursor = {
      package = pkgs.nordzy-cursor-theme;
      gtk.enable = true;
      name = "Nordzy-cursors";
      x11.enable = true;
    };
    activation = {
      k3dDirectories = lib.hm.dag.entryAfter ["writeBoundary"] ''
        /run/current-system/sw/bin/hyprctl reload
        mkdir -p $HOME/.kubedata/openebs
        mkdir -p $HOME/.kubedata/udev
        '';
    };
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

  gtk = {
    enable = true;
    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };
  };

  qt = {
    enable = true;
    style = {
      package = pkgs.nordic;
      name = "Nordic";
    };
  };

  fonts.fontconfig.enable = true;
}
