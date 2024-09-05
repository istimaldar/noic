{ lib, ... }:
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
    "KP_Insert"
    "KP_End"
    "KP_Down"
    "KP_Next"
  ];
  buildWorkapaces = modifier: action: lib.imap1 (index: key: "${modifier}, ${key}, ${action}, ${(toString index)}") workspacesHostkeys; in
[
  "$mod, D, exec, pkill fuzzel || fuzzel"
  "$mod, Q, killactive"
  "$mod SHIFT, Q, exit"
  "$mod SHIFT, R, forcerendererreload"

  "$mod, S, togglefloating"
  "$mod, G, togglegroup"
  "$mod, C, changegroupactive"
  "$mod, R, togglesplit"
  "$mod, F, fullscreen"

  "$mod, L, exec, hyprlock"

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
  ++ (buildWorkapaces "$mod2" "movetoworkspace")

