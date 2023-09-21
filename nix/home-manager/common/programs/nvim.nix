{ pkgs, ... }: {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  coc = {
    enable = true;
    settings = {
      languageserver = {
        nixd = {
          command = "nil";
          rootPatterns = [
            "flake.nix"
          ];
          filetypes = [
            "nix"
          ];
        };

        bash = {
          command = "bash-language-server";
          args = [
            "start"
          ];
          filetypes = [
            "sh"
          ];
        };
      };
    };
  };
  extraConfig = ''
    colorscheme nord
  '';
  plugins = with pkgs.vimPlugins; [
    vim-airline
    auto-pairs
    nerdcommenter
    neoformat
    nerdtree
    vim-multiple-cursors
    vim-highlightedyank
    SimpylFold
    coc-markdownlint
    nord-nvim
    coc-ltex
  ];
}
