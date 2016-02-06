.PHONY= all centos-server-7 fedora-server-23 clean

all: centos-server-7 fedora-server-23

centos-server-7.virtualbox.box: centos-server-7.json http/centos-server-7/* scripts/*
	packer build -only=virtualbox-iso -force centos-server-7.json
	vagrant box add --force --provider virtualbox --name lohsy/centos-server-7 centos-server-7.virtualbox.box

centos-server-7.vmware.box: centos-server-7.json http/centos-server-7/* scripts/*
	packer build -only=vmware-iso -force centos-server-7.json
	vagrant box add --force --provider vmware_desktop --name lohsy/centos-server-7 centos-server-7.vmware.box

fedora-server-23.virtualbox.box: fedora-server-23.json http/fedora-server-23/* scripts/*
	packer build -only=virtualbox-iso -force fedora-server-23.json
	vagrant box add --force --provider virtualbox --name lohsy/fedora-server-23 fedora-server-23.virtualbox.box

fedora-server-23.vmware.box: fedora-server-23.json http/fedora-server-23/* scripts/*
	packer build -only=vmware-iso -force fedora-server-23.json
	vagrant box add --force --provider vmware_desktop --name lohsy/fedora-server-23 fedora-server-23.vmware.box


centos-server-7: centos-server-7.virtualbox.box centos-server-7.vmware.box

fedora-server-23: fedora-server-23.virtualbox.box fedora-server-23.vmware.box

clean:
	-rm -rf packer_cache *.box

clobber: clean
	-vagrant box remove lohsy/centos-server-7 --provider virtualbox -f
	-vagrant box remove lohsy/centos-server-7 --provider vmware_desktop -f
	-vagrant box remove lohsy/fedora-server-23 --provider virtualbox -f
	-vagrant box remove lohsy/fedora-server-23 --provider vmware_desktop -f
