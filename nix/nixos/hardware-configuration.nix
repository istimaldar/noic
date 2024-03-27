{ config, lib, pkgs, host, ... }:
{
  imports = [ ];

  boot = {
    initrd = {
      availableKernelModules = lib.lists.optional host.amdGpu "amdgpu" ++ [
        "kvm-amd"
        "kvm-intel"
        "ata_piix"
        "ohci_pci"
        "ehci_pci"
        "ahci"
        "nvme"
        "sd_mod"
        "sr_mod"
      ];
      kernelModules = lib.lists.optional host.amdGpu "amdgpu" ++  [
        "dm-snapshot"
      ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/lvm-root";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

    "/home" = {
      device = "/dev/mapper/lvm-root";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    "/nix" = {
      device = "/dev/mapper/lvm-root";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/persist" = {
      device = "/dev/mapper/lvm-root";
      fsType = "btrfs";
      options = [ "subvol=persist" ];
    };

    "/var/log" = {
      device = "/dev/mapper/lvm-root";
      fsType = "btrfs";
      options = [ "subvol=log" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/nix-boot";
      fsType = "vfat";
    };
  } // host.extraMounts;

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
