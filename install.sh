#!/usr/bin/env bash

set -exuo pipefail

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
fi
