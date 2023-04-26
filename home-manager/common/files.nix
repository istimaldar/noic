{ pkgs, ... }: {
  ".config/hypr/hyprland.conf".source = ./files/hyprland/hyprland.conf;
  ".config/hypr/monitors.conf".source = ./files/hyprland/monitors.kionithar.conf;
  
  ".p10k.zsh".source = ./files/.p10k.zsh;
}