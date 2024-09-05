{ pkgs, ... }: {
  ".logseq/config/config.edn".source = ./logseq/config.edn;
  ".local/kavita/config/appsettings.json".source = ./kavita/appsettings.json;
  ".p10k.zsh".source = ./oh-my-zsh/.p10k.zsh;
  ".continue/config.json".source = ./continue/config.json;
  ".config/btop/themes/Catppuccin.theme".source = "${pkgs.catppuccin}/btop/catppuccin_macchiato.theme";
  ".config/godot/text_editor_themes/Capuccin.tet".source = (pkgs.fetchFromGitHub {
      name = "godot";
      owner = "catppuccin";
      repo = "godot";
      rev = "27eb55df40f728c5b8e378d9a7c04e1eb6b48819";
      hash = "sha256-okLbhXzFg+5wGVCMoEMY1bdOB7yYk36bBkynuRmtd9c=";
  }) + "/themes/Catppuccin Macchiato.tet";
  ".config/k9s/skins/catppuccin.yaml".source = "${pkgs.catppuccin}/k9s/catppuccin-macchiato.yaml";
}
