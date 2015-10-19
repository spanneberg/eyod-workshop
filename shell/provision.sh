#!/bin/sh

if [ $(getent passwd vagrant) ]; then
  ENVIRONMENT=dev
else
  ENVIRONMENT=production
  git clone https://github.com/spanneberg/eyod-workshop.git /tmp/provisioning
  mv /tmp/provisioning/puppet /opt/puppet
  rm -rf /tmp/provisioning
fi

echo "Running provisiong for $(hostname)/$(hostname -i) in environment ${ENVIRONMENT}"

# run r10k
echo "Running r10k ..."
$( cd /opt/puppet/environments/$ENVIRONMENT/r10k; r10k puppetfile install )

# apply puppet manifests
echo "Running Puppet ..."
/opt/puppetlabs/bin/puppet apply \
  --hiera_config=/opt/puppet/hiera/hiera.yaml \
  --detailed-exitcodes \
  --environmentpath /opt/puppet/environments/ \
  --environment $ENVIRONMENT \
  /opt/puppet/environments/$ENVIRONMENT/manifests/site.pp
