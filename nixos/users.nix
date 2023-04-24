{ pkgs, ... }:
{
  istimaldar = {
    isNormalUser = true;
    extraGroups = [
      "sudo"
    ];
  };
}
