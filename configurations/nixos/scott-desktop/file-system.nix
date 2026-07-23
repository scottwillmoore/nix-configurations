let
  deviceByPartitionLabel = label: "/dev/disk/by-partlabel/${label}";
  deviceByLabel = label: "/dev/disk/by-label/${label}";

  bootPartitionDevice = deviceByPartitionLabel "boot";
  dataPartitionDevice = deviceByPartitionLabel "data";

  dataDeviceLabel = "data";
  dataDevice = deviceByLabel dataDeviceLabel;

  bootFileSystem = {
    device = bootPartitionDevice;
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  mkDataFileSystem = volume: {
    device = dataDevice;
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
      "subvol=${volume}"
    ];
  };

  swapFileSystem = {
    device = dataDevice;
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=swap"
    ];
  };

  swapMountPath = "/swap";
in
{
  boot.initrd.luks.devices = {
    ${dataDeviceLabel} = {
      device = dataPartitionDevice;
    };
  };

  fileSystems = {
    "/" = mkDataFileSystem "root";
    "/boot" = bootFileSystem;
    "/home" = mkDataFileSystem "home";
    "/nix" = mkDataFileSystem "nix";
    "/var/cache" = mkDataFileSystem "cache";
    "/var/log" = mkDataFileSystem "log";
    ${swapMountPath} = swapFileSystem;
  };

  boot.zswap.enable = true;
  swapDevices = [
    {
      device = "${swapMountPath}/swapfile";
      size = 16 * 1024; # 16 GiB
    }
  ];
}
