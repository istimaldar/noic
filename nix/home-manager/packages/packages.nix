{ lib, pkgs, host, ... }:
let helm = import ./helm.nix { inherit pkgs; };
    python = import ./python.nix { inherit pkgs; };
    gcloud = import ./gcloud.nix { inherit pkgs; };
in builtins.concatMap
  (
    x:
    let file_name = builtins.replaceStrings [ "_" ] [ "-" ] x; in
    import (./features + "/${file_name}.nix") { inherit lib pkgs host helm python gcloud; }
  )
  (
    builtins.filter
    (
      x: (builtins.getAttr x host.features).enable
    )
    (
      builtins.attrNames host.features
    )
  )

