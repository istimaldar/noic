{ pkgs, host, ... }: with pkgs;
let helmWithPackages = (wrapHelm kubernetes-helm 
    { 
      plugins =  with kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
      ]; 
    }
  );
  gpuWhisper = (
    let torchPackage = if host.amdGpu then python3Packages.torchWithRocm else python3Packages.torch;
    in
    openai-whisper.override {
      cudaSupport = host.amdGpu;
      torch = torchPackage;
      torchWithCuda = torchPackage;
      transformers = python3Packages.transformers.override {
        torch = torchPackage;
      };
    }
  );
  pythonWithPackages = (python310.withPackages(ps: with ps; [
    virtualenv
  ]));
in  [
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
  helmWithPackages
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
  vagrant
  packer
  openssl
  protobuf
  ansible
  ansible-lint
  yt-dlp
  jwt-cli

  krita
  insomnia
  mitmproxy
  httpie
  fd
  duf
  tldr
  logseq
  spotifywm
  spicetify-cli
  gomplate
  zettlr
  texlive.combined.scheme-full

  podman-compose
  buildah
  skopeo

  gnumake
  jdk
  maven
  go
  dotnet-sdk
  pythonWithPackages
  poetry
  julia
  
  jetbrains.rider
  jetbrains.pycharm-professional
  jetbrains.idea-ultimate
  jetbrains.datagrip
  jetbrains.goland
  jetbrains.clion

  obs-studio
  audacity
  olive-editor
  tesseract
  gpuWhisper
  ffmpeg_6-full
  vlc

  mesa
  ocl-icd
  clinfo

  terraform-ls

  istimaldar.kubelocal
]