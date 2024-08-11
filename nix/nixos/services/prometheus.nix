{ config, ... }: {
  enable = true;
  port = 3020;
  globalConfig.scrape_interval = "10s";
  scrapeConfigs = [
    {
      job_name = "node";
      static_configs = [
        {
          targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
        }
      ];
    }
  ];
  exporters = {
    node = {
      enable = true;
      port = 3021;
      enabledCollectors = [ "systemd" ];
      extraFlags = [
        "--collector.ethtool"
        "--collector.softirqs"
        "--collector.tcpstat"
        "--collector.wifi"
      ];
    };
  };
}
