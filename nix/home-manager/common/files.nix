{ pkgs, host, ... }: {

  # ".logseq/config/plugins.edn".source = ./files/logseq/plugins.edn;
  ".logseq/config/config.edn".source = ./files/logseq/config.edn;

  ".local/kavita/config/appsettings.json".source = ./files/kavita/appsettings.json;

  ".p10k.zsh".source = ./files/.p10k.zsh;

  ".continue/config.json".source = ./files/continue/config.json;

  ".config/btop/themes/Catppuccin.theme".source = "${pkgs.catppuccin}/btop/catppuccin_macchiato.theme";

  ".config/godot/text_editor_themes/Capuccin.tet".source = (pkgs.fetchFromGitHub {
      name = "godot";
      owner = "catppuccin";
      repo = "godot";
      rev = "main";
      hash = "sha256-uN0XP+G+56bUYsye6z8fJt4Xg588FU1LCQ04huONmBQ=";
  }) + "/themes/Catppuccin Macchiato.tet";

  ".config/k9s/skins/catppuccin.yaml".source = "${pkgs.catppuccin}/k9s/catppuccin-macchiato.yaml";
}
