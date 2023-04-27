{ pkgs, ... }: with pkgs; [
  nerdfonts
  megasync
  keepassxc
  pinentry

  slack
  skypeforlinux
  telegram-desktop
  webcord

  doctl
  kubectl
  k9s

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