.PHONY= all centos-7 fedora-server-23 clean

all: centos-7 fedora-server-23

centos-7.virtualbox.box:
	packer build -only=virtualbox-iso -force centos-7.json
	vagrant box add --force --provider virtualbox --name lohsy/centos-7 centos-7.virtualbox.box


centos-7.vmware.box:
	packer build -only=vmware-iso -force centos-7.json
	vagrant box add --force --provider vmware_desktop --name lohsy/centos-7 centos-7.vmware.box

fedora-server-23.virtualbox.box:
	packer build -only=virtualbox-iso -force fedora-server-23.json
	vagrant box add --force --provider virtualbox --name lohsy/fedora-server-23 fedora-server-23.virtualbox.box

fedora-server-23.vmware.box:
	packer build -only=vmware-iso -force fedora-server-23.json
	vagrant box add --force --provider vmware_desktop --name lohsy/fedora-server-23 fedora-server-23.vmware.box


centos-7: centos-7.virtualbox.box centos-7.vmware.box

fedora-server-23: fedora-server-23.virtualbox.box fedora-server-23.vmware.box

clean:
	-vagrant box remove lohsy/centos-7 --provider virtualbox -f
	-vagrant box remove lohsy/centos-7 --provider vmware_desktop -f
	-vagrant box remove lohsy/fedora-server-23 --provider virtualbox -f
	-vagrant box remove lohsy/fedora-server-23 --provider vmware_desktop -f
	-rm -rf packer_cache *.box
