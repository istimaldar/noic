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
      "$primary_monitor" = "DP-2";
      "$secondary_monitor" = "HDMI-A-1";
      "$ternary_monitor" = "HDMI-A-1";

      workspace = [
        "1, monitor:$primary_monitor, on-created-empty:code, defaultName:vscode"
        "2, monitor:$ternary_monitor, default:true, on-created-empty:firefox, defaultName:browser"
        "3, monitor:$primary_monitor, default:true, on-created-empty:alacritty, defaultName:terminal"
        "4, monitor:$secondary_monitor, default:true, on-created-empty:slack && skypeforlinux, defaultName:work_messangers"
        "5, monitor:$primary_monitor, on-created-empty:logseq, defaultName:journal"
        "6, monitor:$secondary_monitor, on-created-empty:telegram-desktop, defaultName:telegram"
        "7, monitor:$primary_monitor, defaultName:ide_primary"
        "8, monitor:$secondary_monitor, on-created-empty:mailspring --password-store=gnome-libsecret, defaultName:mail"
        "9, monitor:$primary_monitor, defaultName:ide_secondary"
        "10, monitor:$ternary_monitor, on-created-empty:spotify, defaultName:spotify"
        "11, monitor:$primary_monitor, defaultName:ide_tertiary"
        "12, monitor:$secondary_monitor, on-created-empty:keepassxc, defaultName:passwords"
        "13, monitor:$secondary_monitor, defaultName:devtools"
      ];

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

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
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
