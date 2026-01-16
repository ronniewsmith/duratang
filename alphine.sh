#!/bin/sh
alias _logger='logger -st "${0##*/}"'
# Variables
MY_USER=""
MY_SSH=""
MY_IFACE="eth0"
MY_HOSTNAME="alpine-sys"
MY_DISK="sda"
# setup-alpine
_logger "Starting base sys-disk installation"
cat <<-EOF > /tmp/ANSWERFILE
  KEYMAPOPTS="us us"
  HOSTNAMEOPTS="$MY_HOSTNAME"
  DEVDOPTS=mdev
	INTERFACESOPTS="auto lo
	iface lo inet loopback

	auto $MY_IFACE
	iface $MY_IFACE inet dhcp
	"
  # DNSOPTS="-d example.com 8.8.8.8"
  TIMEZONEOPTS="America/New_York"
  PROXYOPTS=none
  NTPOPTS=chrony
  APKREPOSOPTS="-f -c"
  USEROPTS="-a -u -g audio,input,video,netdev $MY_USER"
  USERSSHKEY="https://github.com/$MY_SSH.keys"
  SSHDOPTS=openssh
  # export ERASE_DISKS=/dev/$MY_DISK
  DISKOPTS="-m sys /dev/$MY_DISK"
  LBUOPTS=none
  APKCACHEOPTS=none
  EOF

setup-alpine -f /tmp/ANSWERFILE
