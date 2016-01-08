#!/bin/bash
vagrant destroy -f
rm -rf Vagrantfile
vagrant init lohsy/fedora-server-23
vagrant up --provider=vmware_fusion
