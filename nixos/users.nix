{ pkgs, ... }:
{
  istimaldar = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };
}
