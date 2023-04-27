{
  description = "NixOS system and Home Manager configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nur, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ./overlays/hyprland.nix)
          (import ./overlays/insomnia.nix)
        ];
      };
      mkHostConfiguration = host: nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        specialArgs = { inherit host; };

        modules = [
          nur.nixosModules.nur
          hyprland.nixosModules.default
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.istimaldar.imports = [
              ({ config, ... }: import ./home-manager/home.nix {
                inherit config pkgs host;
              })
            ];
          }
        ];
      };
    in {
      nixosConfigurations = 
      {
        kionithar = mkHostConfiguration {
          name = "kionithar";
          waybarOn = [];
        };
        lirianiko = mkHostConfiguration {
          name = "lirianiko";
          waybarOn = [
            "HDMI-A-1"
          ];
        };
      };
      defaultPackage.x86_64-linux = with pkgs; 
      stdenv.mkDerivation {
        name = "install.sh";
        phases = [ "installPhase" ];
        src = ./.;
        installPhase = "mkdir -p $out/bin; ls $src; install -t $out/bin $src/install.sh";
      };
    };

}
