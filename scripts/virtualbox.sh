#!/bin/bash -x -e

echo "Installing VirtualBox Guest Additions"
echo "Running: $(facter virtual)"

# Bail if we are not running inside VirtualBox.
if [[ `facter virtual` == "vmware" ]]; then
	echo "Not Installing VirtualBox Guest Additions"
	exit 0
fi

echo "Proceed to install VirtualBox Guest Additions"


if [[ -n "$(type -P apt-get)" ]]; then
 # Debian and derivatives
 apt-get install build-essential dkms gcc git linux-headers-$(uname -r) make patch perl psmisc unzip wget zip -y
 apt-get remove open-vm-tools -y
elif [[ -n "$(type -P dnf)" ]]; then
 # Fedora, CentOS or RHEL and derivatives
 dnf -y install bzip2 dkms kernel-devel make
 dnf -y remove open-vm-tools
elif [[ -n "$(type -P yum)" ]]; then
 # Fedora, CentOS or RHEL and derivatives
 yum -y install bzip2 dkms kernel-devel make
 yum -y remove open-vm-tools
fi

# Uncomment this if you want to install Guest Additions with support for X
# sudo dnf -y install xorg-x11-server-Xorg


systemctl start dkms
systemctl enable dkms

mkdir -p /mnt/virtualbox
mount -o loop /home/vagrant/VBoxGuest*.iso /mnt/virtualbox
sh /mnt/virtualbox/VBoxLinuxAdditions.run
ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
umount /mnt/virtualbox
rm -rf /home/vagrant/VBoxGuest*.iso



