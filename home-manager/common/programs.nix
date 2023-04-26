{ pkgs, ... }: {
  vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions =  pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "languagetool-linter";
        publisher = "davidlday";
        version = "0.20.0";
        sha256 = "x1/6+2/27ygKu8N/eX6wDwo/HIkHGKPo7S8+gqrDeVk=";
      }
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
        name = "gitlens";
        publisher = "eamodio";
        version = "2023.4.1305";
        sha256 = "1aiw4r6gv3x18krpdgnx721s3a4jg0fa6l5hp4865kzjfv7m0032";
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
        name = "vscode-java-pack";
        publisher = "vscjava";
        version = "0.25.2023032708";
        sha256 = "1fn2rqxip1839iw2skv1wwymirzbsh9iynqhdp60gkimg2w36504";
      }
      {
        name = "errorlens";
        publisher = "usernamehw";
        version = "3.9.0";
        sha256 = "GFMVELwM9ugCNeaq51mibZf0V4hRGate1L3WOgMYAQQ=";
      }
      {
        name = "vscode-conventional-commits";
        publisher = "vivaxy";
        version = "1.25.0";
        sha256 = "KPP1suR16rIJkwj8Gomqa2ExaFunuG42fp14lBAZuwI=";
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

          bar = {
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
}