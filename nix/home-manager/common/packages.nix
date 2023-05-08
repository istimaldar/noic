{ pkgs, ... }: with pkgs; [
  nerdfonts
  megasync
  keepassxc
  pinentry
  hyprpaper
  slurp
  grim
  wl-clipboard

  slack
  skypeforlinux
  telegram-desktop
  webcord
  mattermost-desktop

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
  unzip
  liquibase
  awscli2
  jq
  terraform
  openssl
  protobuf
  yt-dlp

  krita
  insomnia
  mitmproxy
  httpie
  fd
  duf
  tldr
  logseq

  podman-compose
  buildah
  skopeo

  gnumake
  jdk
  maven
  go
  dotnet-sdk
  poetry
  (python310.withPackages(ps: with ps; [
    virtualenv
    torchWithRocm
  ]))

  jetbrains.rider
  jetbrains.pycharm-professional
  jetbrains.idea-ultimate
  jetbrains.datagrip

  obs-studio
  audacity
  olive-editor
  tesseract
  openai-whisper
  ffmpeg_6-full
  vlc

  mesa
  ocl-icd
  clinfo
]