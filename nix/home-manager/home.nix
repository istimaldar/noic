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
    shellAliases = {
      vpna5 = "openvpn3 session-start --config $HOME/.openvpn/a5labs.ovpn";
      vpnka = "openvpn3 session-start --config $HOME/.openvpn/kashxa.ovpn";
      vpnno = "openvpn3 sessions-list | grep Path | awk '{ print $2 }' | xargs -I{} openvpn3 session-manage -D --session-path {}";
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

    kavita = {
      Unit = {
        Description = "Kavita Server";
        After = [
          "network.target"
        ];
      };

      Service = {
        Type = "simple";
        WorkingDirectory = "/home/istimaldar/.local/kavita";
        ExecStart = "${pkgs.kavita}/bin/kavita";
        TimeoutStopSec = 20;
        KillMode = "process";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [
          "multi-user.target"
        ];
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
