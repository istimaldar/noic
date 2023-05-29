{ config, pkgs, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
        useOSProber = true;
      };
    };

    plymouth = {
      enable = true;
      themePackages = [
        pkgs.nixos-bgrt-plymouth
      ];
      theme = "nixos-bgrt";
    };

    initrd = {
      systemd.enable = true;
      luks.devices = {
        root = {
          device = "/dev/disk/by-label/nix-root";
          preLVM = true;
        };
      };
    };

    kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
      "net.netfilter.nf_conntrack_max" = 524288;
      "vm.overcommit_memory" = 1;
      "net.ipv4.ip_forward" = 1;
      "kernel.panic" = 10;
      "kernel.panic_on_oops" = 1;
      "fs.file-max" = 92233720;
      "vm.max_map_count" = 262144;

    };
  };

  # Yes, we need half of KDE just to run Nordic theme for SDDM ¯\_(ツ)_/¯
  environment = {
    systemPackages = with pkgs; [
      nordic
      libsForQt5.plasma-framework
      libsForQt5.plasma-workspace
      libsForQt5.qt5.qtgraphicaleffects
    ];
    etc = {
      "vbox/networks.conf".text = ''
      * 10.128.0.0/16 192.168.56.0/21
      '';
    };
  };

  hardware.opengl = if host.amdGpu then {
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
    ];
    driSupport = true;
  } else {};

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];

  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  users = {
    users = import ./users.nix pkgs;
    extraGroups.vboxusers.members = [
      "istimaldar"
    ];
  };

  nix = {
    extraOptions = ''
    experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "Fri 22:00:00";
    };
  };

  programs = {
    hyprland = {
      enable = true;

      xwayland = {
        enable = true;
        hidpi = true;
      };
    };

    zsh = {
      enable = true;
    };

    openvpn3 = {
      enable = true;
    };
  };

  systemd.services."user@".serviceConfig = {
    Delegate = true;
    LimitNOFILE = 281096;
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = if host.amdGpu then [ "amdgpu" ] else [ "modesetting" "fbdev" ];
      displayManager = {
        defaultSession = "hyprland";
        sddm = {
          enable = true;
          enableHidpi = true;
          theme = "Nordic/Nordic";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    dnsmasq = {
      enable = true;
      settings = {
        address = "/local.gd/127.0.0.1";
        server = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
    };


    gnome.gnome-keyring.enable = true;
  };

  security = {
    polkit = {
      enable = true;
    };

    pki.certificateFiles = [
      ../../certificates/mitmproxy-ca-cert.pem
      ../../certificates/rootCACert.pem
    ];
  };

  virtualisation = {
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };

  networking = {
    hostName = host.name;
    networkmanager = {
      enable = true;
      dns = "default";
    };
    nameservers = [
      "127.0.0.1"
    ];
  };

  time.timeZone = "Asia/Tbilisi";

  system.stateVersion = "22.11";
}

