#!/usr/bin/env bash

set -euo pipefail

export SCRIPT=0
export FORMAT=0
export SWAP=8

usage() {
    cat <<HELP
Usage:
    install.sh ( -f | --format ) ( -d | --device ) [ -w | --swap ] [ -s | --script ]
    install.sh ( -b | --boot-partition ) ( -i | --install-partition ) [ -w | --swap ] [ -s | --script ]

-s, --script                                    Run in script mode. Do not prompt for user output.
-f, --format                                    Format device and create GPT partition table before installation.
-d <device>, --device <device>                  Device to format and install system to.
-b <partition>, --boot-partition <partition>    Partition to mount as boot.
-i <partiton>, --install-partition <partition>  Partition to install system on.
-w <size>, --swap <size>                        Size of the swap partition in gigabytes. [default: 8]
HELP

    exit 2;
}

# Parse argumets
ARGUMENTS=$(getopt -n install.sh -o sfd:b:i:w: \
-l script,format,device:,boot-partition:,install-partition:,swap: -- "$@")

ARGUMENTS_VALID=$?
if [[ "$ARGUMENTS_VALID" != "0" ]]; then
  usage
fi

eval set -- "$ARGUMENTS"
while :;
do
  case $1 in
    -s | --script)            export SCRIPT=1                ; shift;    ;;
    -f | --format)            export FORMAT=1                ; shift;    ;;
    -d | --device)            export DEVICE="$2"             ; shift 2;  ;;
    -b | --boot-partition)    export BOOT_PARTITION="$2"     ; shift 2;  ;;
    -i | --install-partition) export INSTALL_PARTITION="$2"  ; shift 2;  ;;
    -w | --swap)              export SWAP="$2"               ; shift 2;  ;;
    --)                       shift                          ; break;    ;;
    *) echo "Unexpected option: $1 - this should not happen."
       usage ;;
  esac
done

# Validate arguments
if [[ "$FORMAT" == "1" && -z "$DEVICE" ]];
then
  echo "If you want to install with device formatting you must specify the device.";
  usage;
fi


if [[ "$FORMAT" == "0" && ( -z "$BOOT_PARTITION" || -z "$INSTALL_PARTITION") ]];
then
  echo "If you want to install without device formatting you must specify both boot and install partitions.";
  usage;
fi

# Format device
if [[ "$FORMAT" == "1" ]];
then
  parted "$DEVICE" -- mklabel gpt
  parted "$DEVICE" -- mkpart ESP fat32 1MB 512MB
  parted "$DEVICE" -- set 1 esp on
  parted "$DEVICE" -- mkpart primary 512MB 100%
  readarray -t PARTITIONS < <(lsblk "$DEVICE" -o NAME -ln)
  export BOOT_PARTITION="/dev/${PARTITIONS[1]}"
  export INSTALL_PARTITION="/dev/${PARTITIONS[2]}"
fi

# Create encrypted container
mkfs.vfat -n nix-boot "$BOOT_PARTITION"
cryptsetup --verify-passphrase -v luksFormat "$INSTALL_PARTITION" --label nix-root
cryptsetup open "$INSTALL_PARTITION" enc

# Create volumes inside cryptocontainer
pvcreate /dev/mapper/enc
vgcreate lvm /dev/mapper/enc
lvcreate --size "${SWAP}GB" --name swap lvm
lvcreate --extents 100%FREE --name root lvm

# Format partitions in cryptocontainer
mkswap /dev/lvm/swap
mkfs.btrfs /dev/lvm/root

# Create subvolumes for btrfs
swapon /dev/lvm/swap
mount -t btrfs /dev/lvm/root /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/persist
btrfs subvolume create /mnt/log
btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
umount /mnt

# Mount the directories
mount -o subvol=root,compress=zstd,noatime /dev/lvm/root /mnt
mkdir /mnt/home
mount -o subvol=home,compress=zstd,noatime /dev/lvm/root /mnt/home
mkdir /mnt/nix
mount -o subvol=nix,compress=zstd,noatime /dev/lvm/root /mnt/nix
mkdir /mnt/persist
mount -o subvol=persist,compress=zstd,noatime /dev/lvm/root /mnt/persist
mkdir -p /mnt/var/log
mount -o subvol=log,compress=zstd,noatime /dev/lvm/root /mnt/var/log
mkdir /mnt/boot
mount "$BOOT_PARTITION" /mnt/boot

# Enable flakes support
mkidr -p /etc/nix
cat <<CONFIG | tee -a /etc/nix/nix.conf
experimental-features = nix-command flakes
CONFIG
nixos-install --flake https://github.com/istimaldar/noic#system
