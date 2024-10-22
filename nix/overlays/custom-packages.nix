self: super:
{
  istimaldar = {
    installer = import ../packages/installer.nix { pkgs = super; };
  };
}
