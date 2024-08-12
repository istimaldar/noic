{ lib, pkgs, host, ... }: {
  vscode = import ./programs/vscode.nix { inherit pkgs host; };

  neovim = import ./programs/nvim.nix { inherit pkgs host; };

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

  fuzzel = import ./programs/fuzzel.nix { inherit pkgs host; };

  yazi = import ./programs/yazi.nix { inherit lib pkgs host; };

  hyprlock = import ./programs/hyprlock.nix { };

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
    config = {
      theme = "catppuccin";
    };
    themes = {
      catppuccin = {
        src = "${pkgs.catppuccin}/bat";
        file = "Catppuccin Macchiato.tmTheme";
      };
    };
  };

  btop = {
    enable = true;
    settings = {
      color_theme = "Catppuccin";
    };
  };

  eza = {
    enable = true;
    enableZshIntegration = true;
    icons = true;
  };

  fzf = {
    enable = true;
  };

  zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd=cd"
    ];
  };

  thefuck = {
    enable = true;
    enableInstantMode = true;
    enableZshIntegration = true;
  };

  k9s = {
    enable = true;
    settings = {
      k9s = {
        ui = {
          skin = "catppuccin";
        };
      };
    };
  };
}
