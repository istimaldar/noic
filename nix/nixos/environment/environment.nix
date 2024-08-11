{ pkgs, ... }: {
  systemPackages = with pkgs; [
    spotify
    libsForQt5.plasma-framework
    libsForQt5.plasma-workspace
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtquickcontrols2
    catppuccin-sddm-corners
    virtiofsd
  ];
}
