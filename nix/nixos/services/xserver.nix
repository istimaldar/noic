{ host, ... }: {
  enable = true;
  videoDrivers = if host.amdGpu then [ "amdgpu" ] else [ "modesetting" "fbdev" ];
}
