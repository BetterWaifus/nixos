{ config, pkgs, lib, host, user, ... }:
{
  # Sanoid is a snapshotting tool for ZFS
  # How to format drives to ZFS:
  # 1. Wipe drive using GParted
  # 2. ls -al /dev/disk/by-id
  # 3. sudo zpool create -f -o -ashift=12 -O compression=on -O acltype=posixacl -O atime=off -O xattr=sa -O normalization=formD -O mountpoint=none POOL_NAME /dev/disk/by-id/ata... 
  ## add "-o autotrim=on" if using a SSD
  # 4. sudo zfs create -o mountpoint=legacy DATASET 
  ## When creating a dataset you must make a dataset for each level for example doing /media/2TB_SSHD you need to make a dataset for media and media/2TB_SSHD
  services.sanoid = {
    enable = true;
    datasets."zfs-pool-2TB_SSHD/media" = {
      hourly = 50;
      daily = 20;
      weekly = 6;
      monthly = 3;
    };
    datasets."zfs-pool-2TB_SSHD/media/2TB_SSHD" = {
      hourly = 50;
      daily = 20;
      weekly = 6;
      monthly = 3;
    };
    datasets."zfs-pool-4TB_HDD/media" = {
      hourly = 50;
      daily = 20;
      weekly = 6;
      monthly = 3;
    };
    datasets."zfs-pool-4TB_HDD/media/4TB_HDD" = {
      hourly = 50;
      daily = 20;
      weekly = 6;
      monthly = 3;
    };
    datasets."zroot/safe" = {
      hourly = 50;
      daily = 20;
      weekly = 6;
      monthly = 3;
    };
  };
}
