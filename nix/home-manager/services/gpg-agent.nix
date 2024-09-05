{ pkgs, ... }: {
  enable = true;
  enableZshIntegration = true;
  pinentryPackage = pkgs.pinentry-gnome3;
}
