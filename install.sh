#!/bin/bash

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Configure user nobody to match unRAID's settings
usermod -u 99 nobody
usermod -g 100 nobody
usermod -d /home nobody
chown -R nobody:users /home

# Disable SSH
rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################

# Repositories

add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ utopic main restricted"
add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ vivid main restricted"


add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"

# Install Dependencies
apt-get update -qq

# Install Dependencies - pull Python 2.7.9 from vivid APT repo
apt-get -t vivid install -qy python2.7 python-cheetah python-lxml
apt-get install -qy ca-certificates wget unrar unzip git

#########################################
##             INSTALLATION            ##
#########################################

# Install Couchpotato
mkdir -p /opt/couchpotato
wget -qO - https://github.com/RuudBurger/CouchPotatoServer/archive/build/2.6.1.tar.gz | tar -C /opt/couchpotato -zx --strip-components 1

#########################################
##                 CLEANUP             ##
#########################################

# Clean APT install files
apt-get clean -y
rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*
