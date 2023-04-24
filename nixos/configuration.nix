{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" ];
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  boot.initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-label/nix-root";
        preLVM = true;
      };
  };

  users.users = import ./users.nix pkgs;

  nix = {
    extraOptions = ''
    experimental-features = nix-command flake
    '';
    gc = {
      automatic = true;
      dates = "Fri 22:00:00";
    };
  };

  networking.hostName = "kionithar";
  networking.networkmanager.enable = true;

  system.stateVersion = "22.11";
}

