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
  # File System

  boot.initrd.luks.devices = {
    ${dataDeviceLabel} = {
      device = dataPartitionDevice;
    };
  };

  fileSystems = {
    "/" = mkDataFileSystem "root";
    "/boot" = bootFileSystem;
    "/nix" = mkDataFileSystem "nix";
    ${swapMountPath} = swapFileSystem;
  };

  # Swap

  boot.zswap.enable = true;
  swapDevices = [
    {
      device = "${swapMountPath}/swapfile";
      size = 8 * 1024; # 8 GiB
    }
  ];
}
