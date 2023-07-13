{ pkgs, host, ... }: {
  enable = true;
  settings = import ./wofi/settings.nix { inherit pkgs host; };
  style = (builtins.readFile ./wofi/style.css);
}