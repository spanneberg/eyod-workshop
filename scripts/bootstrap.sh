#!/bin/sh

# bootstrap new machines with the command
# > curl https://raw.githubusercontent.com/spanneberg/eyod-workshop/master/scripts/bootstrap.sh | sh
# with superuser rights

# todo
# * create cron job to run puppet
# * create dir under /var/log to hold logs of puppet runs
# * create logrotation for log dir

echo "$(date +\"%T\"): Running bootsrapping"

# fix broken locale
echo "Generating locales ..."
locale-gen de_DE.UTF-8 en_US.UTF-8

echo "Installing packages ..."
apt-get -y install git ruby1.9.1

# install puppet 4 and remove unused deps
echo "Checking Puppet installation ..."
if [ ! -e /opt/puppetlabs ]; then
  echo "Not found. Installing Puppet"
  cd /tmp
  wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
  dpkg -i puppetlabs-release-pc1-trusty.deb
  apt-get update
  apt-get -y install puppet-agent
  apt-get autoremove -y
else
  echo "Already installed."
fi

# install r10k to manage puppet dependencies
echo "Checking r10k installation ..."
if [ -z "$( gem list | grep r10k )" ]; then
  gem install r10k
else
  echo "Already installed."
fi

if [ ! -e /bin/provision.sh ]; then
  echo "Installing for provisioning script ..."
  curl https://raw.githubusercontent.com/spanneberg/eyod-workshop/master/scripts/provision.sh > /bin/provision.sh
  chmod +x /bin/provision.sh
fi
