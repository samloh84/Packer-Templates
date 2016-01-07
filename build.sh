#!/bin/bash
vagrant destroy -f
rm -rf Vagrantfile
rm -rf fedora-server-23.*.box
rm -rf packer_cache
vagrant box remove lohsy/fedora-server-23 --provider vmware_desktop -f

set -e
packer build -parallel=false -force fedora-server-23.json
vagrant box add --force --provider virtualbox --name lohsy/fedora-server-23 fedora-server-23.virtualbox.box
vagrant box add --force --provider vmware_desktop --name lohsy/fedora-server-23 fedora-server-23.vmware.box
