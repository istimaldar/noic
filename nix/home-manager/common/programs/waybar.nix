{ pkgs, host, ... }: {
  enable = true;
  settings = {
    mainBar = import ./waybar/mainBar.nix { inherit pkgs host; };
  };
  style = (builtins.readFile ./waybar/style.css);
}