#!/bin/bash
vagrant destroy -f
rm -rf Vagrantfile
vagrant init lohsy/centos-7
vagrant up --provider=vmware_fusion
