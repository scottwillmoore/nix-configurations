let
  bootFileSystem = {
    device = "dev/disk/by-label/boot";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  mkDataFileSystem = subvolume: {
    device = "/dev/disk/by-label/data";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
      "subvol=${subvolume}"
    ];
  };
in
{
  boot.initrd.luks.devices."data".device = "/dev/disk/by-partlabel/data";

  fileSystems."/boot" = bootFileSystem;

  fileSystems."/" = mkDataFileSystem "root";
  fileSystems."/home" = mkDataFileSystem "home";
  fileSystems."/nix" = mkDataFileSystem "nix";
  fileSystems."/var/cache" = mkDataFileSystem "cache";
  fileSystems."/var/log" = mkDataFileSystem "log";
}
