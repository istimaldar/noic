{ config, lib, pkgs, host, ... }:
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
      virtiofsd
    ];
    etc = {
      "libvirt/qemu.conf".text = ''
      memory_backing_dir = "/dev/shm"
      '';
    };
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
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    k3s = {
      enable = host.features.kubernetes.enable;
      role = if host.features.kubernetes.server then "server" else "agent" ;
      token = if host.features.kubernetes.ha then "vBhBmda4ID46l6YzwXHM" else "";
      clusterInit = host.features.kubernetes.ha && host.features.kubernetes.server;
      serverAddr = if host.features.kubernetes.ha && !host.features.kubernetes.server then "https://192.168.100.5:6443" else "";
      extraFlags = if host.features.kubernetes.server then toString [
        "--write-kubeconfig-mode=644"
        "--disable=metrics-server"
      ] else "";
    };
    u9fs = {
      enable = true;
    };
    nfs = {
      server = {
        enable = true;
      };
    };

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
    libvirtd = {
      enable = true;
      onBoot = "start";
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
    };

    waydroid.enable = true;
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
      "127.0.0.1"
    ];
    firewall = {
        enable = true;
        allowedTCPPorts = [
          22
          80
          443
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

