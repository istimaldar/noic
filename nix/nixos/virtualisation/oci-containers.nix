{ config, ... }: {
  backend = "podman";
  containers = {
    open-webui = {
      image = "ghcr.io/open-webui/open-webui:main";
      autoStart = true;
      ports = [
        "0.0.0.0:3040:8080"
      ];
      volumes = [
        "open-webui:/app/backend/data"
      ];
      labels = {
        "io.containers.autoupdate" = "registry";
      };
      environment = {
        OLLAMA_BASE_URL = "http://ollama.local:${toString config.services.ollama.port}";
        ANONYMIZED_TELEMETRY = "False";
      };
      extraOptions = [
        "--network=slirp4netns:allow_host_loopback=true"
        "--add-host=ollama.local:10.0.2.2"
      ];
      log-driver = "journald";
    };
  };
}
