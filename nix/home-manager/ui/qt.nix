{ pkgs, ... }: {
  enable = true;
  style = {
    package = pkgs.catppuccin;
    name = "Catppuccin-Macchiato";
  };
}
