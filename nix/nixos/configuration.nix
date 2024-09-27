{ config, lib, pkgs, mpkgs, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = import ./boot/boot.nix { inherit pkgs; };
  environment = import ./environment/environment.nix { inherit pkgs; };
  nix = import ./nix/nix.nix { };
  networking = import ./networking/networking.nix { inherit host; };
  programs = import ./programs/programs.nix { inherit config; };
  security = import ./security/security.nix { };
  services = import ./services/services.nix { inherit config mpkgs host; };
  virtualisation = import ./virtualisation/virtualisation.nix { inherit config; };

  hardware.graphics = if host.amdGpu then {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  } else {};

  systemd.tmpfiles.rules = lib.lists.optional host.amdGpu "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}";

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

