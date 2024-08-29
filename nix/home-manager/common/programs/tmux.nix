{ pkgs, ... }: {
  enable = true;
  clock24 = true;
  disableConfirmationPrompt = true;
  historyLimit = 50000;
  baseIndex = 1;
  mouse = true;
  plugins = with pkgs.tmuxPlugins; [
    fpp
    cpu
    tmux-fzf
    {
      plugin = catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavor 'macchiato'
      '';
    }
  ];
  extraConfig = ''
    set -g default-terminal screen-256color
  '';
}
