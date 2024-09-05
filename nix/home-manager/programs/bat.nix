{ pkgs, ... }: {
  enable = true;
  extraPackages = with pkgs.bat-extras; [ batman batgrep batwatch ];
  config = {
    theme = "catppuccin";
  };
  themes = {
    catppuccin = {
      src = "${pkgs.catppuccin}/bat";
      file = "Catppuccin Macchiato.tmTheme";
    };
  };
}
