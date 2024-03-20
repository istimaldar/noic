{ pkgs, host, ... }: {
  dunst = import ./services/dnust.nix { inherit pkgs host; };

  gpg-agent =  {
    enable = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  megasync = {
    enable = true;
  };
}
