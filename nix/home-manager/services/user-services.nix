{ pkgs, ... }: {
  mitmproxy = {
    Unit = {
      Description = "A free and open source interactive HTTPS proxy";
    };

    Service = {
      ExecStart = "${pkgs.mitmproxy}/bin/mitmweb";
    };
  };

  kavita = {
    Unit = {
      Description = "Kavita Server";
      After = [
        "network.target"
      ];
    };

    Service = {
      Type = "simple";
      WorkingDirectory = "/home/istimaldar/.local/kavita";
      ExecStart = "${pkgs.kavita}/bin/kavita";
      TimeoutStopSec = 20;
      KillMode = "process";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [
        "multi-user.target"
      ];
    };
  };
}
