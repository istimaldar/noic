{ pkgs, host, ... }: {
  ".config/hypr/hyprland.conf".source = ./files/hyprland/hyprland.conf;
  ".config/hypr/monitors.conf".source = ./. + "/files/hyprland/monitors.${host.name}.conf";
  
  ".p10k.zsh".source = ./files/.p10k.zsh;
}