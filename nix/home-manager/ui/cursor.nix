{ pkgs, ... }: {
  package = pkgs.catppuccin-cursors.macchiatoLavender;
  gtk.enable = true;
  name = "catppuccin-macchiato-lavender-cursors";
  x11.enable = true;
}
