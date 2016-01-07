#!/bin/bash
vagrant destroy -f
rm -rf Vagrantfile
rm -rf fedora-server-23.virtualbox.box
rm -rf packer_cache
vagrant box remove lohsy/fedora-server-23 --provider virtualbox -f

set -e
packer build -only=virtualbox-iso -force fedora-server-23.json
vagrant box add --force --provider virtualbox --name lohsy/fedora-server-23 fedora-server-23.virtualbox.box
