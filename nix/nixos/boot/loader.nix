{ pkgs, ... }: {
  efi.canTouchEfiVariables = true;
  timeout = 21;
  grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
    useOSProber = true;
    configurationLimit = 9;
    theme = "${pkgs.catppuccin}/grub";
  };
}
