{
  description = "NixOS system and Home Manager configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
  };

  outputs = { nixpkgs, nur, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.system = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        inherit system;

        modules = [
          ./configuration.nix
        ];
      };
    };

}
