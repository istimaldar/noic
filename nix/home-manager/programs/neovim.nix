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
    colorscheme catppuccin-macchiato

    set laststatus=2
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_statusline_ontop=0
    let g:airline_theme='nord'
    let g:airline#extensions#tabline#formatter = 'default'

    autocmd StdinReadPre * let s:std_in=1
  '';
  plugins = with pkgs.vimPlugins; [
    vim-airline
    auto-pairs
    nerdcommenter
    neoformat
    yazi-nvim
    catppuccin-nvim
    vim-airline-themes
    vim-multiple-cursors
    vim-highlightedyank
    SimpylFold
    coc-markdownlint
    nord-nvim
    coc-ltex
    coc-pyright
    nvim-dap
    vim-airline-themes
  ];
}
