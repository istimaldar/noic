{ lib, config, pkgs, mpkgs, spkgs, host, nur, ... }:
{
  home = {
    username = "istimaldar";
    homeDirectory = "/home/istimaldar";
    packages = import ./common/packages.nix { inherit pkgs mpkgs spkgs host nur; };
    file = import ./common/files.nix { inherit pkgs host; };
    sessionVariables = import ./common/variables.nix pkgs;
    pointerCursor = {
      package = pkgs.catppuccin-cursors.macchiatoLavender;
      gtk.enable = true;
      name = "Catppuccin-Macchiato-Lavender-Cursors";
      x11.enable = true;
    };
    activation = {
      k3dDirectories = lib.hm.dag.entryAfter ["writeBoundary"] ''
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

    kubelocal = {
      Unit = {
        Description = "Kubelocal k3d service";
        After = [
          "network.target"
        ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.istimaldar.kubelocal}/bin/kubelocal.sh";
        ExecStop = "${pkgs.istimaldar.kubelocal}/bin/kubelocal.sh stop";
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

  programs = import ./common/programs.nix { inherit lib pkgs host; };

  services = import ./common/services.nix pkgs;

  wayland = import ./common/wayland.nix { inherit pkgs host; };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk;
      name = "catppuccin-macchiato-lavender-compact";
    };
  };

  qt = {
    enable = true;
    style = {
      package = pkgs.catppuccin;
      name = "Catppuccin-Macchiato";
    };
  };

  fonts.fontconfig.enable = true;
}
