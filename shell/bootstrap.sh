#!/bin/sh

echo "Running bootsrapping"

# fix broken locale
echo "Generating locales ..."
sudo locale-gen de_DE.UTF-8 en_US.UTF-8

# install puppet 4 and remove unused deps
echo "Checking Puppet installation ..."
if [ ! -e /opt/puppetlabs ]; then
  echo "Not found. Installing Puppet"
  cd /tmp
  wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
  sudo dpkg -i puppetlabs-release-pc1-trusty.deb
  sudo apt-get update
  sudo apt-get -y install puppet-agent
  sudo apt-get autoremove -y
else
  echo "Already installed."
fi

# install r10k to manage puppet dependencies
echo "Checking r10k installation ..."
if [ -z "$( gem list | grep r10k )" ]; then
  sudo gem install r10k
else
  echo "Already installed."
fi
