{ pkgs, ... }: {
  dunst = {
    enable = true;
  };

  gpg-agent =  {
    enable = true;
    enableZshIntegration = true;
    pinentryFlavor = "gnome3";
  };
}