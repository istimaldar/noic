{ pkgs, host, ... }: {
  vscode = import ./programs/vscode.nix { inherit pkgs host; };

  neovim = import ./programs/nvim.nix { inherit pkgs host; };

  wofi = import ./programs/wofi.nix { inherit pkgs host; };

  firefox = {
    enable = true;
  };

  chromium = {
    enable = true;
  };

  gpg = {
    enable = true;
    mutableTrust = true;
  };

  git = import ./programs/git.nix { inherit pkgs host; };

  zsh = import ./programs/zsh.nix { inherit pkgs host; };

  alacritty = import ./programs/alacritty.nix { inherit pkgs host; };

  waybar = import ./programs/waybar.nix { inherit pkgs host; };

  direnv = {
    enable = true;
    config = {
      whitelist = {
        prefix = [
          "~/code"
        ];
      };
    };
  };

  bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
  };

  htop = {
    enable = true;
  };

  eza = {
    enable = true;
    enableAliases = true;
    icons = true;
  };

  fzf = {
    enable = true;
  };
}
