{ pkgs, host, nur, ... }: with pkgs;
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
      torch = torchPackage;
      transformers = python3Packages.transformers.override {
        torch = torchPackage;
      };
    }
  );
  pythonWithPackages = (python311.withPackages(ps: with ps; [
    virtualenv
    python-lsp-server
  ]));
  gcloud = google-cloud-sdk.withExtraComponents (
    [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
    ]
  );
in  [
  nerdfonts
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
  aws-sam-cli
  jq
  yq-go
  packer
  openssl
  protobuf
  grpc
  yt-dlp
  jwt-cli
  nmap
  glances
  rclone
  storj-uplink

  redis
  tigervnc

  insomnia
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
  talosctl
  cilium-cli

  gnumake
  go
  pythonWithPackages
  poetry
  julia
  ruby
  babashka
  clojure
  yarn
  nodejs_18

  nil
  nodePackages.bash-language-server
  ltex-ls

  jetbrains.pycharm-professional
  jetbrains.dataspell
  jetbrains.datagrip
  jetbrains.goland
  jetbrains.clion
  jetbrains.ruby-mine
  jetbrains.gateway
  jetbrains.webstorm
  lapce
  devpod
  devpod-desktop

  ollama

  spacedrive

  vlc
  qbittorrent

  mesa
  ocl-icd
  clinfo

  mitmproxy

  istimaldar.kubelocal
] ++ lib.lists.optionals host.features.java.enable [
  jetbrains.idea-ultimate
  jdk
  maven
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
  terraform-ls
  terraform
  vagrant
  operator-sdk
] ++ lib.lists.optionals host.features.messangers.enable [
  slack
  mailspring
  skypeforlinux
  telegram-desktop
  whatsapp-for-linux
  webcord
  mattermost-desktop
  # beeper
]
