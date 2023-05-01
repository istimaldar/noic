{ pkgs, host, ... }: {
  ".config/hypr/hyprland.conf".source = ./files/hyprland/hyprland.conf;
  ".config/hypr/monitors.conf".source = ./. + "/files/hyprland/monitors.${host.name}.conf";
  ".config/hypr/hyprpaper.conf".source = ./. + "/files/hyprland/hyperpaper.${host.name}.conf";

  ".logseq/config/plugins.edn".source = ./files/logseq/plugins.edn;
  ".logseq/config/config.edn".source = ./files/logseq/config.edn;
  
  ".p10k.zsh".source = ./files/.p10k.zsh;
}