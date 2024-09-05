{ lib, pkgs, host, ... }: {
  windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$mod2" = "SUPERSHIFT";
      "$mod3" = "ALT";
      "$primary_monitor" = host.monitors.primary;
      "$secondary_monitor" = host.monitors.secondary;
      "$ternary_monitor" = host.monitors.secondary;

      env = import ./wayland/env.nix { };
      workspace = import ./wayland/workspace.nix { };
      bind = import ./wayland/bind.nix { inherit lib; };
      bindm = import ./wayland/bindm.nix { };
      bindel = import ./wayland/bindel.nix { };
      bindl = import ./wayland/bindl.nix { };
      general = import ./wayland/general.nix {};
      input = import ./wayland/input.nix {};
      decoration = import ./wayland/decoration.nix {};
      animations = import ./wayland/animations.nix {};
    };

    extraConfig = (builtins.readFile "${pkgs.catppuccin}/hyprland/macchiato.conf");
  };
}
