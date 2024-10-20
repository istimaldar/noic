{ pkgs, ... }: {
  hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
  };

  zsh = {
    enable = true;
  };

  steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  openvpn3 = {
    enable = true;
    package = pkgs.stable.openvpn3; # TODO: remove when merged upstream
  };
}
