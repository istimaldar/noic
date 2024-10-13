{ host, ... }: {
  enable = host.amdGpu;
  acceleration = "rocm";
  rocmOverrideGfx = "10.3.0";
}
