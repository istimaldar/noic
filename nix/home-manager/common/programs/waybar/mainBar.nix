{ host, ... }: {
  layer = "top";
  position = "top";
  height = 41;
  spacing = 4;
  output = host.waybarOn;
  modules-left = [
    "wlr/workspaces"
    "hyprland/language"
  ];
  modules-center = [
    "clock"
  ];
  modules-right = [
    "tray"
    "cpu"
    "memory"
    "network"
    "pulseaudio"
  ];
  "wlr/workspaces" = {
    disable-scroll = true;
    all-outputs = true;
    format = "{icon}";
    sort-by-number = true;
    format-icons = {
      "1" = "󰨞";
      "2" = "";
      "3" = "";
      "4" = "";
      "5" = "󰒱";
      "6" = "";
      "7" = "";
      "8" = "";
      "9" = "";
      "10" = "󱂛";
      "11" = "";
      "12" = "󰟵";
      "13" = "";
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
    interval= 1;
    format = "{: %Y-%m-%d  %H:%M:%S}";
    tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
  };
  cpu = {
    format = "{usage}% ";
    tooltip = false;
  };
  memory = {
    format = "{}% ";
  };
  network = {
    # "interface": "wlp2*", // (Optional) To force the use of this interface
    format-wifi = "<span font='16' rise='-2500'></span>  {signalStrength}%";
    format-ethernet = "{ipaddr}/{cidr} ";
    tooltip-format = "{ifname} via {gwaddr} ";
    format-linked = "{ifname} (No IP) ";
    format-disconnected = "⚠ Disconnected";
    format-alt = "{ifname}: {ipaddr}/{cidr}";
  };
  pulseaudio = {
    # // "scroll-step": 1, // %, can be a float
    format = "<span font='18' rise='-2500'>{icon}</span> {volume}%";
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