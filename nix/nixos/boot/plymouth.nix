{ pkgs, ... }: {
  enable = true;
  themePackages = [
    pkgs.catppuccin-plymouth
  ];
  theme = "catppuccin-macchiato";
}
