{ pkgs, ... }: with pkgs; [
  nerdfonts
  megasync
  keepassxc
  pinentry

  slack
  skypeforlinux
  telegram-desktop
  webcord

  ncspot

  d2
  languagetool

  insomnia
  mitmproxy

  podman-compose
  buildah
  skopeo

  dotnet-sdk
  poetry
  (python311.withPackages(ps: with ps; [
    virtualenv
  ]))

  jetbrains.rider
  jetbrains.pycharm-professional
  jetbrains.idea-ultimate
]