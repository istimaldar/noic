{ pkgs, host, ... }: {
  vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions =  pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nord-visual-studio-code";
        publisher = "arcticicestudio";
        version = "0.19.0";
        sha256 = "05bmzrmkw9syv2wxqlfddc3phjads6ql2grknws85fcqzqbfl1kb";
      }
      {
        name = "better-toml";
        publisher = "bungcip";
        version = "0.3.2";
        sha256 = "08lhzhrn6p0xwi0hcyp6lj9bvpfj87vr99klzsiy8ji7621dzql3";
      }
      {
        name = "languagetool-linter";
        publisher = "davidlday";
        version = "0.20.0";
        sha256 = "0nbrqfm84gigxpla6607i4f3y2hgn1z7jzy3pc52ivzndzxzlpy7";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "2023.4.2605";
        sha256 = "0wjjkwqy66dn05973qwgnicvm92lc3g2awfpdsly6j4xjcrfwax3";
      }
      {
        name = "kotlin";
        publisher = "fwcd";
        version = "0.2.31";
        sha256 = "1yngrbqndb7jccmakpjv98y8amffvk2zbj3dhz0khdxz6ym18vb3";
      }
      {
        name = "vscode-jetbrains-keybindings";
        publisher = "isudox";
        version = "0.1.9";
        sha256 = "0fb0m1r17lxk132m94gklxkr5y1pmnxgiafciaailsbqv9w3ms33";
      }
      {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "0.2.1";
        sha256 = "0bibb3r4cb7chnx6vpyl41ig12pc0cbg0sb8f2khs52c71nk4bn8";
      }
      {
        name = "kubernetes-templates";
        publisher = "lunuan";
        version = "1.3.1";
        sha256 = "0bjyx9ri7fl68ryy0icn1lc3r8gxkpwaxhh900ij8xfvabqvcx6m";
      }
      {
        name = "vscode-kubernetes-tools";
        publisher = "ms-kubernetes-tools";
        version = "1.3.11";
        sha256 = "1jr74lrjbmciam2zpfajicnj662fij37l31x46i0idhmvvsrssr3";
      }
      {
        name = "vscode-yaml";
        publisher = "redhat";
        version = "1.12.2";
        sha256 = "193spsdrfwl6yf1c9k10c6s6azyq15h4jgz76gqz44c4d2yx0c8j";
      }
      {
        name = "d2";
        publisher = "Terrastruct";
        version = "0.8.6";
        sha256 = "0da7357wxsf2sw7xy19gwldvsycgxwp6ih94bvy9gr6g9pzvkbay";
      }
      {
        name = "helm-intellisense";
        publisher = "Tim-Koehler";
        version = "0.14.3";
        sha256 = "13bs7406g4nq5wfxh90zyp4yq62wlzzwl7gzkill2a56gvrfgiad";
      }
      {
        name = "errorlens";
        publisher = "usernamehw";
        version = "3.10.1";
        sha256 = "1q6i0s9bdqspc0l5df233sga844mwrllcabgy1wxhvyzkyxn7b22";
      }
      {
        name = "vscode-conventional-commits";
        publisher = "vivaxy";
        version = "1.25.0";
        sha256 = "00mv34898y4xgqv6xf57bdl32qbbma4imz08jc4v5skmwjrgbwr8";
      }
      {
        name = "vscode-java-pack";
        publisher = "vscjava";
        version = "0.25.2023042006";
        sha256 = "0igc60dgnhl95cr8z7n4762b4lnf845zrnawnv6f42w7yigqwchz";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2023.7.11161005";
        sha256 = "KKcgTSAl7aDZ6HcQ8aJKt3j4sBDHis33uIFQhENjrNk=";
      }
    ];
    userSettings = {
      "workbench.colorTheme" = "Nord";
      "redhat.telemetry.enabled" = true;
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "languageToolLinter.managed.classPath" = "/home/istimaldar/.nix-profile/share/languagetool-server.jar";
      "languageToolLinter.serviceType" = "managed";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = "500ms";
      "window.menuBarVisibility" = "toggle";
    };
  };

  wofi = {
    enable = true;
  };


  terminator = {
    enable = true;
  };

  firefox = {
    enable = true;
  };

  gpg = {
    enable = true;
    mutableTrust = true;
  };

  git = {
    enable = true;
    lfs.enable = true;
    signing = {
      key = "istimaldar@gmail.com";
      signByDefault = true;
    };
    userName = "istimaldar";
    userEmail = "istimaldar@gmail.com";
    extraConfig.core.sshCommand = "ssh -i ~/.ssh/git/istimaldar";
    includes = [
      {
        condition = "gitdir:~/code/centaurea/";
        contents = {
          user = {
            name = "Kanstancin Fedarcou";
            email = "kf@centaurea.io";
            signingKey = "kf@centaurea.io";
          };
          core.sshCommand = "ssh -i ~/.ssh/git/centaurea";
        };
      }
      {
        condition = "gitdir:~/code/a5labs/";
        contents = {
          user = {
            name = "Kanstancin Fedarcou";
            email = "konstantin.fedortsov@a5labs.co";
            signingKey = "konstantin.fedortsov@a5labs.co";
          };
          core.sshCommand = "ssh -i ~/.ssh/git/a5labs";
        };
      }
      {
        condition = "gitdir:~/code/kashxa/";
        contents = {
          user = {
            name = "DevOps Engineer (K)";
            email = "devops@kashxa.com";
            signingKey = "devops@kashxa.com";
          };
          core.sshCommand = "ssh -i ~/.ssh/git/kashxa";
        };
      }
    ];
  };

  zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    initExtra = ''
    source ~/.p10k.zsh
    '';
    prezto = {
      enable = true;
      prompt.theme = "powerlevel10k";
    };
  };


  alacritty = {
    enable = true;
    settings = {
      font = {
        family = "JetBrainsMono Nerd Font";
      };

      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
          dim_foreground = "#a5abb6";
        };

        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };

        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };

        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };

        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };

          footer_bar = {
            background = "#434c5e";
            foreground = "#d8dee9";
          };
        };

        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };

        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };

        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
      };
    };
  };

  waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 41;
        spacing = 4;
        output = host.waybarOn;
        modules-left = [
          "wlr/workspaces"
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
                "7" = "";
                "8" = "";
                "9" = "";
                "10" = "󱂛";
                "11" = "󱀣";
                "12" = "󰟵";
                urgent = "";
                focused = "";
                default = "";
            };
        };
        "hyprland/language" = {
          format = "{}";
          format-en = "English";
          format-by = "Беларуская";
          format-ge = "ქართული";
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
          format-wifi = "<span font='18' rise='-2500'></span> {signalStrength}%";
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
      };
    };
    style = ''
    @define-color base   #3b4252;
    @define-color mantle #181825;
    @define-color crust  #4c566a;

    @define-color text     #cdd6f4;
    @define-color subtext0 #a6adc8;
    @define-color subtext1 #bac2de;

    @define-color surface0 #313244;
    @define-color surface1 #45475a;
    @define-color surface2 #585b70;

    @define-color overlay0 #6c7086;
    @define-color overlay1 #7f849c;
    @define-color overlay2 #9399b2;

    @define-color blue      #89b4fa;
    @define-color lavender  #b4befe;
    @define-color sapphire  #74c7ec;
    @define-color sky       #89dceb;
    @define-color teal      #94e2d5;
    @define-color green     #a6e3a1;
    @define-color yellow    #f9e2af;
    @define-color peach     #fab387;
    @define-color maroon    #eba0ac;
    @define-color red       #bf616a;
    @define-color mauve     #cba6f7;
    @define-color flamingo  #f2cdcd;
    @define-color rosewater #f5e0dc;

    * {
      font-family: Fira Code;
      font-size: 14px;
    }

    window#waybar {
      background-color: alpha(@base, 0.9);
      border: 2px solid alpha(@crust, 0.1);
    }

    #clock,
    #battery,
    #backlight,
    #disk,
    #pulseaudio,
    #tray {
      padding: 0 10px;
    }

    #cpu,
    #memory,
    #network {
      padding: 0 7px;
    }

    #clock {
      color: @sky;
    }

    #wifi {
      color: @sapphire;
    }

    #battery {
      color: @green;
    }

    #pulseaudio {
      color: @flamingo;
    }

    #network {
      color: @maroon;
    }

    #backlight {
      color: @mauve;
    }

    #workspaces button {
      color: @text;
      border-radius: 16px;
      transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
    }

    #workspaces button:hover {
      background-color: @mauve;
    }

    #workspaces button.active {
      color: @maroon;
      background-color: shade(@surface1, 0.9);
    }

    .modules-right {
      background-color: @surface1;
      border-radius: 16px;
      margin: 5px 5px 5px 10px;
    }

    .modules-left {
      background-color: @surface1;
      border-radius: 16px;
      margin: 5px;
    }

    .modules-center {
      background-color: @surface1;
      border-radius: 16px;
      margin: 5px;
    }

    .custom-spotify {
      padding: 0 10px;
      color: @green;
    }

    .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
    }
    '';
  };

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

  exa = {
    enable = true;
    enableAliases = true;
    icons = true;
  };

  fzf = {
    enable = true;
  };
}