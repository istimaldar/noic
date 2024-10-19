{ config, lib, pkgs, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = import ./boot/boot.nix { inherit pkgs; };
  environment = import ./environment/environment.nix { inherit lib pkgs host; };
  nix = import ./nix/nix.nix { };
  networking = import ./networking/networking.nix { inherit host; };
  programs = import ./programs/programs.nix { inherit pkgs; };
  security = import ./security/security.nix { };
  services = import ./services/services.nix { inherit config pkgs host; };
  virtualisation = import ./virtualisation/virtualisation.nix { inherit config lib host; };
  sops = import ./sops/sops.nix { };

  hardware.graphics = lib.attrsets.optionalAttrs host.amdGpu {
    enable = true;
    enable32Bit = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
  };
  users = {
    users = import ./users/users.nix { inherit pkgs; };
    groups.nix-serve = {};
    extraGroups.vboxusers.members = [
      "istimaldar"
    ];
  };

  systemd.services."user@".serviceConfig = {
    Delegate = true;
    LimitNOFILE = 281096;
  };

  time.timeZone = "Asia/Tbilisi";

  system.stateVersion = "22.11";
}

