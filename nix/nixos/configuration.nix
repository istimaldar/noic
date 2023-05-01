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
        version = 2;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
        useOSProber = true;
      };
    };

    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-label/nix-root";
        preLVM = true;
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

  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  users.users = import ./users.nix pkgs;

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
      displayManager = {
        defaultSession = "hyprland";
        sddm = {
          enable = true;
          enableHidpi = true;
        };
      };
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
    ];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };

  networking.hostName = host.name;
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tbilisi";

  system.stateVersion = "22.11";
}

