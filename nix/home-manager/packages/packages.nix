{ pkgs, mpkgs, spkgs, host, nur, ... }: with pkgs;
let helmWithPackages = (wrapHelm kubernetes-helm
    {
      plugins =  with kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
      ];
    }
  );
  pythonWithPackages = (python312.withPackages(ps: with ps; [
    virtualenv
    python-lsp-server
    jupyter-core
    ipykernel
    notebook
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
  ntfs3g

  d2
  languagetool
  devbox
  unzip
  spkgs.liquibase
  awscli2
  jq
  yq-go
  packer
  openssl
  protobuf
  grpc
  yt-dlp
  jwt-cli
  nmap
  rclone
  storj-uplink
  glab
  jira-cli-go
  neofetch
  dua
  nix-du
  graphviz
  sops
  age
  dig
  mtr
  teller
  viddy
  cue
  kcl
  vivid

  redis
  tigervnc

  insomnia
  httpie
  fd
  duf
  tldr
  yazi
  logseq
  anki
  gomplate
  zettlr
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
  nodejs_22

  nil
  nodePackages.bash-language-server
  ltex-ls

  jetbrains.pycharm-professional
  jetbrains.dataspell
  jetbrains.datagrip
  jetbrains.goland
  jetbrains.clion
  jetbrains.ruby-mine
  jetbrains.webstorm
  godot_4

  spacedrive

  vlc
  qbittorrent
  google-chrome

  mesa
  ocl-icd
  clinfo

  mitmproxy
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
  ffmpeg_6-full
  krita
] ++ lib.lists.optionals host.features.cloud.enable [
  doctl
  kubectl
  kube-capacity
  helmWithPackages
  helmsman
  kube3d
  go-task
  gcloud
  ansible
  ansible-lint
  molecule
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
  discord
  betterdiscordctl
  mattermost-desktop
  element-desktop
]
