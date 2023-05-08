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
    romc = {
      url = "github:nixos-rocm/nixos-rocm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nur, home-manager, hyprland, romc, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ./nix/overlays/hyprland.nix)
          (import ./nix/overlays/insomnia.nix)
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
      defaultPackage.x86_64-linux = with pkgs; 
      stdenv.mkDerivation {
        name = "install.sh";
        phases = [ "installPhase" ];
        src = ./.;
        installPhase = "mkdir -p $out/bin; ls $src; install -t $out/bin $src/install.sh";
      };
      packages.x86_64-linux.kubelocal = with pkgs; 
      stdenv.mkDerivation {
        name = "kubelocal";
        src = ./kubernetes;
        buildInputs = [
          which
          envsubst
          k9s
          (pkgs.wrapHelm pkgs.kubernetes-helm 
            { 
              plugins =  with kubernetes-helmPlugins; [
                helm-secrets
                helm-diff
              ]; 
            }
          )
          helmsman
          kube3d
          kubectl
          podman
          jq
          gnused
          wl-clipboard
        ];
      };
    };

}
