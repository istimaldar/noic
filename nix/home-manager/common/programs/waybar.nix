{ pkgs, host, ... }: {
  enable = true;
  settings = {
    mainBar = import ./waybar/mainBar.nix { inherit pkgs host; };
  };
  systemd = {
    enable = true;
  };
  style = (builtins.readFile ./waybar/style.css);
}
