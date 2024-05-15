{ config, lib, pkgs, host, sddm-catppuccin, spkgs, ... }:
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
        configurationLimit = 2;
        theme = "${pkgs.catppuccin}/grub";
      };
    };

    plymouth = {
      enable = true;
      themePackages = [
        pkgs.catppuccin-plymouth
      ];
      theme = "catppuccin-macchiato";
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
      "kernel.panic" = 10;
      "kernel.panic_on_oops" = 1;
      "fs.file-max" = 92233720;
      "vm.max_map_count" = 262144;

    };
  };

  environment = {
    systemPackages = with pkgs; [
      spotify
      libsForQt5.plasma-framework
      libsForQt5.plasma-workspace
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtsvg
      libsForQt5.qt5.qtquickcontrols2
      catppuccin-sddm-corners
      virtiofsd
    ];
  };

  hardware.opengl = if host.amdGpu then {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
    driSupport = true;
  } else {};

  systemd.tmpfiles.rules = lib.lists.optional host.amdGpu "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}";

  hardware = {
    enableRedistributableFirmware = true;
  };
  users = {
    users = import ./users.nix { inherit pkgs host; };
    groups.nix-serve = {};
    extraGroups.vboxusers.members = [
      "istimaldar"
    ];
  };

  nix = {
    extraOptions = ''
    experimental-features = nix-command flakes
    min-free = ${toString (10 * 1024 * 1024 * 1024)}
    max-free = ${toString (25 * 1024 * 1024 * 1024)}
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
    settings = {
      auto-optimise-store = true;
    };
  };

  programs = {
    hyprland = {
      enable = true;

      xwayland = {
        enable = true;
      };

    };

    zsh = {
      enable = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
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
    ollama = {
      package = spkgs.ollama;
      enable = true;
      acceleration = "rocm";
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    u9fs = {
      enable = true;
    };
    nfs = {
      server = {
        enable = true;
      };
    };

    displayManager = {
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        enableHidpi = true;
        theme = "catppuccin-sddm-corners";
      };
    };

    xserver = {
      enable = true;
      videoDrivers = if host.amdGpu then [ "amdgpu" ] else [ "modesetting" "fbdev" ];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
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
    libvirtd = {
      enable = true;
      onBoot = "start";
      allowedBridges = [
        "virbr0"
      ];
      nss = {
        enable = true;
        enableGuest = true;
      };
      qemu = {
        verbatimConfig = ''
          namespaces = []
          memory_backing_dir = "/dev/shm"
        '';
      };
    };

    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers = {
      backend = "podman";
      containers = {
        open-webui = {
          image = "ghcr.io/open-webui/open-webui:main";
          autoStart = true;
          ports = [
            "0.0.0.0:3000:8080"
          ];
          volumes = [
            "open-webui:/app/backend/data"
          ];
          labels = {
            "io.containers.autoupdate" = "registry";
          };
          environment = {
            OLLAMA_BASE_URL = "http://ollama.local:11434";
            ANONYMIZED_TELEMETRY = "False";
          };
          extraOptions = [
            "--network=slirp4netns:allow_host_loopback=true"
            "--add-host=ollama.local:10.0.2.2"
          ];
        };
      };
    };

    lxd.enable = true;
  };

  networking = {
    hostName = host.name;
    networkmanager = {
      enable = true;
      dns = "default";
      wifi = {
        scanRandMacAddress = false;
        powersave = false;
        backend = "iwd";
      };
    };
    nameservers = [
      "1.1.1.1"
    ];
    firewall = {
        enable = true;
        allowedTCPPorts = [
          22
          80
          443
          3000
          6443
        ];
        allowedUDPPorts = [
          8472
        ];
    };
  };

  time.timeZone = "Asia/Tbilisi";

  system.stateVersion = "22.11";
}

