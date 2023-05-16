{ pkgs, host, ... }: {
  enable = true;
  settings = {
    mainBar = import ./waybar/mainBar.nix { inherit pkgs host; };
  };
  style = import ./waybar/style.nix { inherit pkgs host; };
}