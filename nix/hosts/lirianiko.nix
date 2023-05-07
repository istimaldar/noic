{
  name = "lirianiko";
  waybarOn = [
    "HDMI-A-1"
  ];
  extraMounts = {
    "/mnt/c" = {
      device = "/dev/nvme0n1p3";
      fsType = "ntfs3"; 
      options = [
        "rw"
        "uid=1000"
      ];
    };
  };
}
