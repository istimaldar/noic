{ lib, pkgs, ... }: let
themeSettings = builtins.fromTOML (builtins.readFile ../files/yazi/catppuccin.toml);
highlightPatch = {
  manager = {
    syntect_theme = "${pkgs.catppuccin}/bat/Catppuccin Macchiato.tmTheme";
  };
};
theme = lib.attrsets.recursiveUpdate themeSettings highlightPatch;
in {
  enable = true;
  enableZshIntegration = true;
  theme = theme;
}
