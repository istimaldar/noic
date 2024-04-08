{ pkgs, host, ... }: {
  enable = true;
  settings = {
    mainBar = import ./waybar/mainBar.nix { inherit pkgs host; };
  };
  systemd = {
    enable = true;
    target = "hyprland-session.target";
  };
  style = (builtins.readFile "${pkgs.catppuccin}/waybar/macchiato.css") + "\n" + (builtins.readFile ./waybar/style.css);
}
