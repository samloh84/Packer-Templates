#!/bin/bash

# Bail if we are not running inside VMWare.
if [[ `facter virtual` != "vmware" ]]; then
    exit 0
fi

if [[ -n "$(type -P apt-get)" ]]; then
 # Debian and derivatives
 apt-get install build-essential dkms gcc git linux-headers-$(uname -r) make patch perl psmisc unzip wget zip -y
 apt-get remove open-vm-tools -y
elif [[ -n "$(type -P dnf)" ]]; then
 # Fedora, CentOS or RHEL and derivatives
 dnf -y install gcc glibc-headers kernel-devel kernel-headers make perl git wget
 dnf -y remove open-vm-tools
elif [[ -n "$(type -P yum)" ]]; then
 # Fedora, CentOS or RHEL and derivatives
 yum -y install gcc glibc-headers kernel-devel kernel-headers make perl git wget
 yum -y remove open-vm-tools
fi

git clone https://github.com/rasa/vmware-tools-patches.git
pushd vmware-tools-patches
./download-tools.sh 8.1.0
./untar-and-patch.sh
./compile.sh
popd
rm -rf vmware-tools-patches

sed -i.bak 's/answer AUTO_KMODS_ENABLED_ANSWER no/answer AUTO_KMODS_ENABLED_ANSWER yes/g' /etc/vmware-tools/locations
sed -i.bak 's/answer AUTO_KMODS_ENABLED no/answer AUTO_KMODS_ENABLED yes/g' /etc/vmware-tools/locations

vmware-config-tools.pl -d

