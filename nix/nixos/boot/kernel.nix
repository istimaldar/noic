{ ... }: {
  sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
    "net.netfilter.nf_conntrack_max" = 524288;
    "vm.overcommit_memory" = 1;
    "kernel.panic" = 10;
    "kernel.panic_on_oops" = 1;
    "fs.file-max" = 92233720;
    "vm.max_map_count" = 262144;
  };
}
