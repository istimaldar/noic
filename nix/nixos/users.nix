{ host, pkgs, ... }:
{
  istimaldar = {
    isNormalUser = true;
    extraGroups = [
      "qemu-libvirtd"
      "libvirtd" 
      "wheel"
      "podman"
      "render"
      "video"
      "networkmanagerF"
    ];
    shell = pkgs.zsh;
  };
} // (
if host.serveCache then 
{
  nix-serve = {
    isSystemUser = true;
    group = "nix-serve";
  };
}
else {})
