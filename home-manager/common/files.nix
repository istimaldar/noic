{ pkgs, ... }: {
  ".config/hypr/hyprland.conf".source = ./files/hyprland.conf;
  ".p10k.zsh".source = ./files/.p10k.zsh;
}