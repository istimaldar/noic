#!/usr/bin/env bash

set -euo pipefail

export SCRIPT=0
export FORMAT=0
export DRY_RUN=0
export SWAP=8
export CERPH_SIZE=50
export DEVICE=""
export BOOT_PARTITION=""
export INSTALL_PARTITION=""
export TARGET="kionithar"
export MAX_RETRY_ATTEMPTS=20

usage() {
    cat <<HELP
Usage:
    install.sh ( -f | --format ) ( -d | --device ) [ -w | --swap ] [ -s | --script ] [ -t | --target ] [ -a | --max-retry-attempts ]
    install.sh ( -b | --boot-partition ) ( -i | --install-partition ) [ -w | --swap ] [ -s | --script ] [ -t | --target ] [ -a | --max-retry-attempts ]

-s, --script                                    Run in script mode. Do not prompt for user output.
-f, --format                                    Format device and create GPT partition table before installation.
-r, --dry-run                                   Print script command rather then execute them.
-d <device>, --device <device>                  Device to format and install system to.
-b <partition>, --boot-partition <partition>    Partition to mount as boot.
-i <partiton>, --install-partition <partition>  Partition to install system on.
-w <size>, --swap <size>                        Size of the swap partition in gigabytes. [default: 8]
-c <size>, --cerph <size>                       Size of logical volume for cerph storage. [default: 50]
-t <target>, --target <target>                  Configuration target to apply. [default: kionithar]
-a <attempts>, --max-retry-attempts <attempts>  Max attempts to retry installation (useful in case of network errors). [default: 20]
HELP

    exit 2;
}

execute() {
  local COMMAND="$@"

  if [[ $DRY_RUN -eq 1 ]];
  then
    echo $COMMAND
  else
    eval $COMMAND
  fi
}

# Parse argumets
ARGUMENTS=$(getopt -n install.sh -o sfrd:b:i:w:c:t: \
-l script,format,dry-run,device:,boot-partition:,install-partition:,swap:,cerph:,target: -- "$@")

ARGUMENTS_VALID=$?
if [[ "$ARGUMENTS_VALID" != "0" ]]; then
  usage
fi

eval set -- "$ARGUMENTS"
while :;
do
  case $1 in
    -s | --script)              export SCRIPT=1                ; shift;    ;;
    -f | --format)              export FORMAT=1                ; shift;    ;;
    -r | --dry-run)             export DRY_RUN=1               ; shift;    ;;
    -d | --device)              export DEVICE="$2"             ; shift 2;  ;;
    -b | --boot-partition)      export BOOT_PARTITION="$2"     ; shift 2;  ;;
    -i | --install-partition)   export INSTALL_PARTITION="$2"  ; shift 2;  ;;
    -w | --swap)                export SWAP="$2"               ; shift 2;  ;;
    -c | --cerph)               export CERPH_SIZE="$2"         ; shift 2;  ;;
    -t | --target)              export TARGET="$2"             ; shift 2;  ;;
    -a | --max-retry-attempts)  export MAX_RETRY_ATTEMPTS="$2" ; shift 2;  ;;
    --)                         shift                          ; break;    ;;
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
  execute parted "$DEVICE" -- mklabel gpt
  execute parted "$DEVICE" -- mkpart ESP fat32 1MB 512MB
  execute parted "$DEVICE" -- set 1 esp on
  execute parted "$DEVICE" -- mkpart primary 512MB 100%
  execute readarray -t PARTITIONS < <(lsblk "$DEVICE" -o NAME -ln)
  export BOOT_PARTITION="/dev/${PARTITIONS[1]}"
  export INSTALL_PARTITION="/dev/${PARTITIONS[2]}"
fi

# Create encrypted container
execute mkfs.vfat -n nix-boot "$BOOT_PARTITION"
execute cryptsetup --verify-passphrase -v luksFormat "$INSTALL_PARTITION" --label nix-root
execute cryptsetup open "$INSTALL_PARTITION" enc

# Create volumes inside cryptocontainer
execute pvcreate /dev/mapper/enc
execute vgcreate lvm /dev/mapper/enc
execute lvcreate --size "${SWAP}GB" --name swap lvm
execute lvcreate --size "${CERPH_SIZE}GB" --name cerph lvm
execute lvcreate --extents 100%FREE --name root lvm

# Format partitions in cryptocontainer
execute mkswap /dev/lvm/swap
execute mkfs.btrfs /dev/lvm/root

# Create subvolumes for btrfs
execute swapon /dev/lvm/swap
execute mount -t btrfs /dev/lvm/root /mnt
execute btrfs subvolume create /mnt/root
execute btrfs subvolume create /mnt/home
execute btrfs subvolume create /mnt/nix
execute btrfs subvolume create /mnt/persist
execute btrfs subvolume create /mnt/log
execute btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
execute umount /mnt

# Mount directories
execute mount -o subvol=root,compress=zstd,noatime /dev/lvm/root /mnt
execute mkdir /mnt/home
execute mount -o subvol=home,compress=zstd,noatime /dev/lvm/root /mnt/home
execute mkdir /mnt/nix
execute mount -o subvol=nix,compress=zstd,noatime /dev/lvm/root /mnt/nix
execute mkdir /mnt/persist
execute mount -o subvol=persist,compress=zstd,noatime /dev/lvm/root /mnt/persist
execute mkdir -p /mnt/var/log
execute mount -o subvol=log,compress=zstd,noatime /dev/lvm/root /mnt/var/log
execute mkdir /mnt/boot
execute mount "$BOOT_PARTITION" /mnt/boot

NEXT_TIMEOUT=0
until execute nixos-install --flake "github:istimaldar/noic#$TARGET" || (( NEXT_TIMEOUT < MAX_RETRY_ATTEMPTS ));
do
  sleep "$(( NEXT_TIMEOUT++ ))"
done
