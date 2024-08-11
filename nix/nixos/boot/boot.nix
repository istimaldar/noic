{ pkgs, ... }: {
  kernelPackages = pkgs.linuxPackages_latest;
  supportedFilesystems = [ "btrfs" ];
  loader = import ./loader.nix { inherit pkgs; };
  plymouth = import ./plymouth.nix { inherit pkgs; };
  initrd = import ./initrd.nix { };
  kernel = import ./kernel.nix { };
}
