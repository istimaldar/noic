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
        height = 33;
        output = host.waybarOn;
    
        modules-left = [
          "wlr/workspaces"
          "hyprland/language"
        ];
        modules-center = [
          "clock"
        ];
        modules-right =  [
          "tray"
          "pulseaudio"
          "custom/power"
        ];

        "wlr/workspaces" = {
          on-click = "activate";
          sort-by-name = false;
          sort-by-number = true;
          all-outputs = true;
          active-only = false;
        };

        "hyprland/language" = {
          format = "{}";
        };

        clock = {
          interval = 1;
          format = "{: %H:%M:%S   %Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        tray = {
          icon-size = 13;
          spacing = 10;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          scroll-step = 1;
          on-click = "pavucontrol";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              "墳"
              ""
            ];
          };
        };

        "custom/power" = {
          format = "⏻";
          on-click = "wlogout";
        };
      };
    };
    style = ''
    * {
      border: none;
      border-radius: 0;
      font-family: monospace;
      font-weight: bold;
      font-size: 14px;
      min-height: 0;
    }

    window#waybar {
      background: transparent;
      color: #cdd6f4;
    }

    tooltip {
      background: #1e1e2e;
      border-radius: 10px;
      border-width: 2px;
      border-style: solid;
      border-color: #11111b;
    }

    #workspaces button {
      padding: 5px;
      color: #313244;
      margin-right: 5px;
    }

    #workspaces button.active {
      color: #a6adc8;
    }

    #workspaces button.focused {
      color: #a6adc8;
      background: #eba0ac;
      border-radius: 10px;
    }

    #workspaces button.urgent {
      color: #11111b;
      background: #a6e3a1;
      border-radius: 10px;
    }

    #workspaces button:hover {
      background: #11111b;
      color: #cdd6f4;
      border-radius: 0;
      border: 0;
      outline: 0;
    }

    #language {
      background: #1e1e2e;
      padding: 0px 10px;
      border-radius: 10px;
      margin-left: 5px;
    }

    #custom-language, #custom-updates, #custom-caffeine, #custom-power, #clock, #battery, #pulseaudio, #network, #workspaces, #tray, #backlight {
      background: #1e1e2e;
      padding: 0px 10px;
      margin: 3px 0px;
    }

    #tray {
      border-radius: 10px;
      margin-right: 4px;
    }

    #workspaces {
      background: #1e1e2e;
      border-radius: 10px;
      padding-right: 0px;
      padding-left: 5px;
      margin-left: 5px;
    }

    #custom-caffeine {
      color: #89dceb;

    }

    #custom-language {
      color: #f38ba8;
    }

    #custom-updates {
      color: #f5c2e7;
    }

    #clock {
      color: #f9e2af;
      border-radius: 10px;
    }

    #network {
      color: #fab387;
      border-radius: 10px 0px 0px 10px;
      padding-right: 12px;
    }

    #pulseaudio {
      color: #89b4fa;
    }

    #battery{
      color:  #a6e3a1;

    }

    #backlight{
      color: #cba6f7;
    }
    #custom-power{
      color: #a6adc8;
      background: #1e1e2e;
      border-radius: 0 10px 10px 0;
      margin-right: 5px;
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