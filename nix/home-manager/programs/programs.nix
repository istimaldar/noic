{ lib, pkgs, mpkgs, host, ... }: {
  alacritty = import ./alacritty.nix { inherit pkgs; };
  bat = import ./bat.nix { inherit pkgs; };
  btop = import ./btop.nix { };
  chromium = import ./chromium.nix { };
  dircolors = import ./dircolors.nix { };
  direnv = import ./direnv.nix { };
  eza = import ./eza.nix { };
  firefox = import ./firefox.nix { inherit mpkgs; };
  fuzzel = import ./fuzzel.nix { };
  fzf = import ./fzf.nix { };
  git = import ./git.nix { };
  gpg = import ./gpg.nix { };
  hyprlock = import ./hyprlock.nix { };
  k9s = import ./k9s.nix { };
  neovim = import ./neovim.nix { inherit pkgs; };
  oh-my-posh = import ./oh-my-posh.nix { };
  vscode = import ./vscode/vscode.nix { inherit pkgs; };
  waybar = import ./waybar/waybar.nix { inherit pkgs host; };
  yazi = import ./yazi/yazi.nix { inherit lib pkgs; };
  zellij = import ./zellij.nix { };
  zoxide = import ./zoxide.nix { };
  zsh = import ./zsh.nix { };
}
