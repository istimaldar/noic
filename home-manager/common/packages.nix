{ pkgs, ... }: with pkgs; [
  nerdfonts
  megasync
  keepassxc
  pinentry
  hyprpaper

  slack
  skypeforlinux
  telegram-desktop
  webcord

  doctl
  kubectl
  k9s
  (pkgs.wrapHelm pkgs.kubernetes-helm 
    { 
      plugins =  with kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
      ]; 
    }
  )
  helmsman
  kube3d
  go-task

  d2
  languagetool
  devbox

  krita
  insomnia
  mitmproxy
  httpie
  fd
  duf
  tldr

  podman-compose
  buildah
  skopeo

  jdk
  maven
  go
  dotnet-sdk
  poetry
  (python311.withPackages(ps: with ps; [
    virtualenv
  ]))

  jetbrains.rider
  jetbrains.pycharm-professional
  jetbrains.idea-ultimate
]