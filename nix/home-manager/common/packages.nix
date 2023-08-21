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
  gcloud = google-cloud-sdk.withExtraComponents (
    [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
    ]
  );
in  [
  nerdfonts
  megasync
  keepassxc
  pinentry
  hyprpaper
  slurp
  grim
  wl-clipboard

  d2
  languagetool
  devbox
  unzip
  liquibase
  awscli2
  jq
  yq-go
  terraform
  vagrant
  packer
  openssl
  protobuf
  grpc
  yt-dlp
  jwt-cli
  glances

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
  spotifywm
  kavita
  texlive.combined.scheme-full

  podman-compose
  podman-desktop
  buildah
  skopeo

  gnumake
  jdk
  maven
  go
  pythonWithPackages
  poetry
  julia
  ruby
  babashka
  clojure
  yarn
  nodejs_18

  jetbrains.pycharm-professional
  jetbrains.idea-ultimate
  jetbrains.datagrip
  jetbrains.goland
  jetbrains.clion
  jetbrains.ruby-mine

  vlc
  qbittorrent

  mesa
  ocl-icd
  clinfo

  terraform-ls

  istimaldar.kubelocal
] ++ lib.lists.optionals host.features.dotnet.enable [
  dotnet-sdk
  jetbrains.rider
] ++ lib.lists.optionals host.features.media_edit.enable [
  obs-studio
  audacity
  olive-editor
  tesseract
  gpuWhisper
  ffmpeg_6-full
  krita
] ++ lib.lists.optionals host.features.cloud.enable [
  doctl
  kubectl
  k9s
  helmWithPackages
  helmsman
  kube3d
  go-task
  gcloud
  ansible
  ansible-lint
] ++ lib.lists.optionals host.features.messangers.enable [
  slack
  skypeforlinux
  telegram-desktop
  webcord
  mattermost-desktop
]
