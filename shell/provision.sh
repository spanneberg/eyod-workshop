#!/bin/sh

echo "Running provisiong"

# todo: check out repo if not in dev environment

# run r10k
echo "Running r10k ..."
$( cd /opt/puppet/environments/production/r10k; r10k puppetfile install )

# apply puppet manifests
echo "Running Puppet ..."
/opt/puppetlabs/bin/puppet apply \
  --hiera_config=/opt/puppet/hiera.yaml \
  --detailed-exitcodes \
  --environmentpath /opt/puppet/environments/ \
  --environment production \
  /opt/puppet/environments/production/manifests/site.pp
