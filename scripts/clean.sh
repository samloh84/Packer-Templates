#!/bin/bash

if [[ -n "$(type -P apt-get)" ]]; then
 # Debian and derivatives
 apt-get clean all
elif [[ -n "$(type -P dnf)" ]]; then
 # Fedora, CentOS or RHEL and derivatives
 dnf clean all
elif [[ -n "$(type -P yum)" ]]; then
 # Fedora, CentOS or RHEL and derivatives
 yum clean all
fi
