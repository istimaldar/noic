{ pkgs, host, ... }: {
  dunst = import ./services/dnust.nix { inherit pkgs host; };

  gpg-agent =  {
    enable = true;
    enableZshIntegration = true;
    pinentryFlavor = "gnome3";
  };

  megasync = {
    enable = true;
  };
}
