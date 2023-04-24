{ config, lib, pkgs, ... }:
{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/lvm-root";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/lvm-root";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/lvm-root";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/persist" = {
    device = "/dev/mapper/lvm-root";
    fsType = "btrfs";
    options = [ "subvol=persist" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/mapper/lvm-root";
    fsType = "btrfs";
    options = [ "subvol=log" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/nix-boot";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/dev/mapper/lvm-swap";
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
