#!/usr/bin/env bash

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

ARGUMENTS=$(getopt -n install.sh -o sfd:b:i:w: \
-l script,format,device:,boot-partition:,install-partition:,swap: -- "$@")

ARGUMENTS_VALID=$?
if [ "$ARGUMENTS_VALID" != "0" ]; then
  usage
fi

