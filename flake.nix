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
    podman-input = {
      url = "github:NickCao/nixpkgs/podman-desktop";
    };
    romc = {
      url = "github:nixos-rocm/nixos-rocm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nur, home-manager, hyprland, podman-input, romc, ... }:
    let
      system = "x86_64-linux";
      podman-pkgs = import podman-input {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ./nix/overlays/hyprland.nix)
          (import ./nix/overlays/insomnia.nix)
          (import ./nix/overlays/custom-packages.nix)
          (self: super: {
            electron = super.electron_24;
            podman-desktop = podman-pkgs.podman-desktop;
          })
        ];
      };
      mkHostConfiguration = host: nixpkgs.lib.nixosSystem {
        inherit pkgs system;
        specialArgs = { inherit host; };

        modules = [
          nur.nixosModules.nur
          hyprland.nixosModules.default
          ./nix/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.istimaldar.imports = [
              ({ lib, config, ... }: import ./nix/home-manager/home.nix {
                inherit lib config pkgs host;
              })
            ];
          }
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
            path = hosts + ("/" + name + ".toml");
            content = pkgs.lib.importTOML path;
            settings = content // { name = name; };
          in { name = name; value = mkHostConfiguration settings; }
        )
        (
          builtins.attrNames (builtins.readDir hosts)
        )
      );
      apps.x86_64-linux = with pkgs.istimaldar; {
        default = {
          type = "app";
          program = "${installer}/bin/install.sh";
        };
        kubelocal = {
          type = "app";
          program = "${kubelocal}/bin/kubelocal.sh";
        };
      };
      packages.x86_64-linux = with pkgs.istimaldar; {
        installer = installer;
        kubelocal = kubelocal;
      };
    };
}
