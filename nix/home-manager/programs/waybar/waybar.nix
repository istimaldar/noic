{ pkgs, host, ... }: {
  enable = true;
  settings = {
    mainBar = import ./main-bar.nix { inherit host; };
  };
  systemd = {
    enable = true;
    target = "hyprland-session.target";
  };
  style = (builtins.readFile "${pkgs.catppuccin}/waybar/macchiato.css") + "\n" + (builtins.readFile ./main-bar.css);
}
