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

        set -g @catppuccin_window_left_separator ""
        set -g @catppuccin_window_right_separator " "
        set -g @catppuccin_window_middle_separator " █"
        set -g @catppuccin_window_number_position "right"

        set -g @catppuccin_window_default_fill "number"
        set -g @catppuccin_window_default_text "#W"

        set -g @catppuccin_window_current_fill "number"
        set -g @catppuccin_window_current_text "#W"

        set -g @catppuccin_status_modules_right "directory user host session"
        set -g @catppuccin_status_left_separator  " "
        set -g @catppuccin_status_right_separator ""
        set -g @catppuccin_status_fill "icon"
        set -g @catppuccin_status_connect_separator "no"

        set -g @catppuccin_directory_text "#{pane_current_path}"
      '';
    }
  ];
  extraConfig = ''
    set -g default-terminal screen-256color
  '';
}
