{
  description = "NixOS system and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nurpkgs.url = "github:nix-community/NUR";
    sops-nix ={
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sddm-catppuccin = {
      url = "github:khaneliman/sddm-catppuccin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-vsc = {
      url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, nixpkgs-master, spicetify-nix, sddm-catppuccin, catppuccin-vsc, nurpkgs, home-manager, sops-nix, ... }:
    let
      system = "x86_64-linux";
      configurePackages = host: input: import input {
        inherit system;
        overlays = map (f: (import (./nix/overlays + "/${f}"))) (builtins.attrNames (builtins.readDir ./nix/overlays)) ++ [catppuccin-vsc.overlays.default];
        config = {
          allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) (import ./nix/configuration/unfree-packages.nix);
          permittedInsecurePackages = (import ./nix/configuration/insecure-packages.nix);
          rocmSupport = host.amdGpu;
        };
      };
      mkHostConfiguration = host: let
        pkgs = (configurePackages host (if host.stable then nixpkgs-stable else nixpkgs)) // {
          master = configurePackages host nixpkgs-master;
          stable = configurePackages host nixpkgs-stable;
        };

        nur = import nurpkgs {
          inherit pkgs;
          nurpkgs = pkgs;
        };
      in nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        specialArgs = { inherit host spicetify-nix sddm-catppuccin; };

        modules = [
          nurpkgs.nixosModules.nur
          ./nix/nixos/configuration.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.istimaldar.imports = [
              ({ lib, config, ... }: import ./nix/home-manager/home.nix {
                inherit lib config pkgs host nur;
              })
            ];
          }
          ./nix/spicefy/spicefy.nix
        ];
      };
      hosts = ./hosts;
    in {
      nixosConfigurations = builtins.listToAttrs (
        builtins.map (
          element:
          let
            name = builtins.head (
              builtins.split "\\." element
            );
            path = hosts + ("/" + name + ".json");
            content = nixpkgs.lib.importJSON path;
            settings = content // { name = name; };
          in { name = name; value = mkHostConfiguration settings; }
        )
        (
          builtins.attrNames (builtins.readDir hosts)
        )
      );
    };
}
