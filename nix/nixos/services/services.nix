{ config, pkgs, host, ... }: {
    displayManager = import ./displayManager.nix { };
    grafana = import ./grafana.nix { inherit config; };
    loki = import ./loki.nix { };
    ollama = import ./ollama.nix { inherit pkgs; };
    openssh = import ./openssh.nix { };
    pipewire = import ./pipewire.nix { };
    prometheus = import ./prometheus.nix { inherit config; };
    promtail = import ./promtail.nix { inherit config; };
    xserver = import ./xserver.nix { inherit host; };

    gnome.gnome-keyring.enable = true;
}
