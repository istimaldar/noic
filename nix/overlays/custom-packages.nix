self: super: 
{
  istimaldar = {
    installer = import ../packages/installer.nix { pkgs = super; };
    kubelocal = import ../packages/kubelocal.nix { pkgs = super; };
    beeper = import ../packages/beeper.nix { pkgs = super; };
  };
  
}