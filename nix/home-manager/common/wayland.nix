{ pkgs, host, ... }:
let
  workspacesHostkeys = [
    "1"
    "2"
    "3"
    "4"
    "5"
    "6"
    "7"
    "8"
    "9"
    "0"
    "minus"
    "equal"
    "backslash"
  ];
  buildWorkapaces = modifier: action: pkgs.lib.imap1 (index: key: "${modifier}, ${key}, ${action}, ${(toString index)}") workspacesHostkeys;
in
{
  windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$mod2" = "SUPERSHIFT";
      "$mod3" = "ALT";

      bind = [
        "$mod, D, exec, pkill fuzzel || fuzzel"
        "$mod, Q, killactive"
        "$mod SHIFT, Q, exit"
        "$mod SHIFT, R, forcerendererreload"

        "$mod, S, togglefloating"
        "$mod, G, togglegroup"
        "$mod, C, changegroupactive"
        "$mod, R, togglesplit"
        "$mod, F, fullscreen"

        "$mod2, S, exec, grim -g \"$(slurp)\" - | wl-copy"

        "$mod3, left, movefocus, l"
        "$mod3, right, movefocus, r"
        "$mod3, up, movefocus, u"
        "$mod3, down, movefocus, d"

        "$mod, left, movewindow, l"
        "$mod, right, movewindow, r"
        "$mod, up, movewindow, u"
        "$mod, down, movewindow, d"
      ] ++ (buildWorkapaces "$mod" "workspace")
      ++ (buildWorkapaces "$mod2" "movetoworkspace");

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      general = {
        border_size = 3;
        gaps_in = 3;
        gaps_out = 2;
        layout = "dwindle";
        "col.active_border" = "$lavender";
      };

      input = {
        kb_layout = "us,by,ru";
        kb_options = "grp:caps_toggle";
        numlock_by_default = true;
        follow_mouse = 1;
        repeat_delay = 250;
        repeat_rate = 30;
      };

      decoration = {
        rounding = 10;

        dim_inactive = true;
        dim_strength = 0.2;

        blur = {
          enabled = true;
          size = 20;
        };
      };

      animations = {
        enabled = true;
      };
    };

    extraConfig = (builtins.readFile "${pkgs.catppuccin}/hyprland/macchiato.conf");
  };
}
