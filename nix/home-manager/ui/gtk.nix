{ pkgs, ... }: {
  enable = true;
  theme = {
    package = pkgs.catppuccin-gtk;
    name = "catppuccin-macchiato-lavender-compact";
  };
}
