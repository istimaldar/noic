{ config, lib, pkgs, mpkgs, host, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = import ./boot/boot.nix { inherit pkgs; };
  environment = import ./environment/environment.nix { inherit lib pkgs host; };
  nix = import ./nix/nix.nix { };
  networking = import ./networking/networking.nix { inherit host; };
  programs = import ./programs/programs.nix { inherit config; };
  security = import ./security/security.nix { };
  services = import ./services/services.nix { inherit config host; };
  virtualisation = import ./virtualisation/virtualisation.nix { inherit config host; };

  hardware.graphics = if host.amdGpu then {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs.rocmPackages; [
      clr.icd
      rocblas
      hipblas
      clr
      rocminfo
    ];
  } else {};

  systemd.tmpfiles.rules =
  let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in lib.lists.optional host.amdGpu "L+    /opt/rocm   -    -    -     -    ${rocmEnv}";

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

