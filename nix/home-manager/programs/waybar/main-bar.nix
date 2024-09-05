{ host, ... }: {
  layer = "top";
  position = "top";
  height = 41;
  spacing = 4;
  output = [
    host.monitors.primary
  ];
  modules-left = [
    "hyprland/workspaces"
    "hyprland/language"
  ];
  modules-center = [
    "clock"
  ];
  modules-right = [
    "tray"
    "disk"
    "cpu"
    "memory"
    "network"
    "pulseaudio"
  ];
  "hyprland/workspaces" = {
    disable-scroll = true;
    all-outputs = true;
    format = "{icon}";
    sort-by-number = true;
    format-icons = {
      vscode = "󰨞";
      browser = "";
      terminal = "";
      work_messangers = "󰒱";
      journal = "";
      telegram = "";
      ide_primary = "";
      mail = "";
      ide_secondary = "";
      spotify = "";
      ide_tertiary = "";
      passwords = "";
      element = "󰘨";
      discord = "";
      devtools = "󱂛";
      ide_quaternary = "";
      urgent = "";
      focused = "";
      default = "";
    };
  };
  "hyprland/language" = {
    format = "{}";
    format-en = "Anhelskaja";
    format-by = "Biełaruskaja";
    format-ka = "Kartuli";
    format-ru = "Rasiejskaja";
  };
  keyboard-state = {
    numlock = true;
    capslock = true;
    format = "{name} {icon}";
    format-icons = {
      locked = "";
      unlocked = "";
    };
  };
  "wlr/mode" = {
    format = "<span style=\"italic\">{}</span>";
  };
  "wlr/scratchpad" = {
    format = "{icon} {count}";
    show-empty = false;
    format-icons = [
      ""
      ""
    ];
    tooltip = true;
    tooltip-format = "{app}: {title}";
  };
  mpd = {
    format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
    format-disconnected = "Disconnected ";
    format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
    unknown-tag = "N/A";
    interval = 2;
    consume-icons = {
      on = " ";
    };
    random-icons = {
      off = "<span color=\"#f53c3c\"></span> ";
      on = " ";
    };
    repeat-icons = {
        on = " ";
    };
    single-icons = {
        on = "1 ";
    };
    state-icons = {
      paused = "";
      playing = "";
    };
    tooltip-format = "MPD (connected)";
    tooltip-format-disconnected = "MPD (disconnected)";
  };
  idle_inhibitor = {
    format = "{icon}";
    format-icons = {
      activated = "";
      deactivated = "";
    };
  };
  tray = {
      icon-size = 15;
      spacing = 10;
  };
  clock = {
    format = "{:%Y-%m-%d %H:%M:%S}  ";
    format-alt = "{:%A, %B %d, %Y (%H:%M:%S)}  ";
    interval = 1;
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      mode = "year";
      mode-mon-col = 3;
      weeks-pos = "right";
      on-scroll =  1;
      on-click-right = "mode";
      format = {
        months = "<span color='#ffead3'><b>{}</b></span>";
        days = "<span color='#ecc6d9'><b>{}</b></span>";
        weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        weekdays = "<span color='#ffcc66'><b>{}</b></span>";
        today = "<span color='#ff6699'><b><u>{}</u></b></span>";
      };
    };
    actions =  {
      on-click-right = "mode";
      on-click-forward = "tz_up";
      on-click-backward = "tz_down";
      on-scroll-up = "shift_up";
      on-scroll-down = "shift_down";
    };
  };
  disk = {
    interval = 30;
    format = "{percentage_free}% 󰉎";
    path = "/";
  };
  cpu = {
    format = "{usage}% ";
    tooltip = false;
  };
  memory = {
    format = "{percentage}%  {swapPercentage}% 󱛟";
  };
  network = {
    # "interface": "wlp2*", // (Optional) To force the use of this interface
    format-wifi = "<span font='16' rise='-2500'></span>  {signalStrength}%";
    format-ethernet = "{ipaddr}/{cidr} 󰈁";
    tooltip-format = "{ifname} via {gwaddr} ";
    format-linked = "{ifname} (No IP) ";
    format-disconnected = "⚠ Disconnected";
    format-alt = "{ifname}: {ipaddr}/{cidr}";
  };
  pulseaudio = {
    # // "scroll-step": 1, // %, can be a float
    format = "<span font='18' rise='-2500'>{icon}</span>  {volume}%";
    format-bluetooth = "{icon} {volume}% ";
    format-bluetooth-muted = " {icon} {format_source}";
    format-muted = " {format_source}";
    format-source = "{volume}% ";
    format-source-muted = "";
    format-icons = {
      headphone = "";
      hands-free = "";
      headset = "";
      phone = "";
      portable = "";
      car=  "";
      default = ["" "" ""];
    };
    on-click = "pavucontrol";
  };
}
