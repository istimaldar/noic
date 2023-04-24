{ config, pkgs, nur, home-manager, ... }:
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
  home-manager = {
    useGlobalPkgs = true;
    users.istimaldar = import ../home-manager/home.nix config pkgs;
  };

  networking.hostName = "kionithar";
  networking.networkmanager.enable = true;

  system.stateVersion = "22.11";
}

