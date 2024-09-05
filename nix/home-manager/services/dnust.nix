{ pkgs, ... }: {
  enable = true;
  settings = {
    global = {
      ### Display ###
      monitor = 0;
      follow = "mouse";
      geometry = "0x0-30+40";
      indicate_hidden = "yes";
      shrink = "no";
      transparency = 0;
      notification_height = 0;
      separator_height = 6;
      padding = 8;
      horizontal_padding = 8;
      frame_width = 2;
      frame_color = "#ff000000";
      separator_color = "frame";
      sort = "yes";
      idle_threshold = 120;
      font = "JetBrainsMono Nerd Font 9";
      line_height = 0;
      markup = "full";
      format = "<b>%s</b>\n%b";
      alignment = "left";
      vertical_alignment = "center";
      show_age_threshold = 60;
      word_wrap = "yes";
      ellipsize = "middle";
      ignore_newline = "no";
      stack_duplicates = true;
      hide_duplicate_count = false;

      ### Icons ###
      show_indicators = "yes";
      icon_position = "left";
      min_icon_size = 0;
      max_icon_size = 32;

      ### History ###
      sticky_history = "yes";
      history_length = 100;

      ### Misc/Advanced ###
      browser = "${pkgs.firefox}/bin/firefox -new-tab";
      always_run_script = true;
      title = "Dunst";
      class = "Dunst";
      startup_notification = false;
      verbosity = "mesg";
      corner_radius = 0;
      ignore_dbusclose = false;

      ### Legacy ###
      force_xinerama = false;

      ### Mouse ###
      mouse_left_click = "close_current";
      mouse_middle_click = "do_action, close_current";
      mouse_right_click = "close_all";
    };
    experimental = {
      per_monitor_dpi = false;
    };
    shortcuts = {
      close = "ctrl+space";
      close_all = "ctrl+shift+space";
      history = "ctrl+grave";
      context = "ctrl+shift+period";
    };
    urgency_low = {
      background = "#2E3440";
      foreground = "#ECEFF4";
      frame_color = "#a3be8c";
      timeout = 15;
    };
    urgency_normal = {
      background = "#2E3440";
      foreground = "#ECEFF4";
      frame_color = "#ebcb8b";
      timeout = 15;
    };
    urgency_critical = {
      background = "#BF616A";
      foreground = "#ECEFF4";
      frame_color = "#bf616a";
      timeout = 0;
    };
  };
}
