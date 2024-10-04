{ lib, pkgs, mpkgs, spkgs, host, nur, ... }: {
  programs = import ./programs/programs.nix { inherit lib pkgs host mpkgs; };
  services = import ./services/services.nix pkgs;
  wayland = import ./ui/wayland.nix { inherit lib pkgs host; };
  gtk = import ./ui/gtk.nix { inherit pkgs; };
  qt = import ./ui/qt.nix { inherit pkgs; };
  systemd.user.services = import ./services/user-services.nix { inherit pkgs; };
  fonts.fontconfig.enable = true;

  home = {
    username = "istimaldar";
    homeDirectory = "/home/istimaldar";
    packages = import ./packages/packages.nix { inherit pkgs mpkgs spkgs host nur; };
    file = import ./files/files.nix { inherit pkgs host; };
    sessionVariables = import ./variables/variables.nix pkgs;
    pointerCursor = import ./ui/cursor.nix { inherit pkgs; };
    shellAliases = import ./aliases/aliases.nix {};
    stateVersion = "22.11";
  };
}
