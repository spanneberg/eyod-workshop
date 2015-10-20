#!/bin/sh

GIT_URL="https://github.com/spanneberg/eyod-workshop.git"
CHECKOUT_DIR="/opt/eyod-workshop"
TARGET_DIR="/opt/puppet"

# check if we run in dev or prod environment and update infra code if we are in prod
if [ $(getent passwd vagrant) ]; then
  ENVIRONMENT=dev
else
  ENVIRONMENT=production
  if [ ! -e $CHECKOUT_DIR ]; then
    git clone $GIT_URL $CHECKOUT_DIR
    ln -s $CHECKOUT_DIR/puppet $TARGET_DIR
  fi
  $( cd $CHECKOUT_DIR && git pull )
fi

echo "$(date +\"%T\"): Running provisiong for $(hostname)/$(hostname -i) in environment ${ENVIRONMENT}"

# run r10k
echo "Running r10k ..."
$( cd $TARGET_DIR/environments/$ENVIRONMENT/r10k && r10k puppetfile install )

# apply puppet manifests
echo "Running Puppet ..."
/opt/puppetlabs/bin/puppet apply \
  --hiera_config=$TARGET_DIR/hiera/hiera.yaml \
  --detailed-exitcodes \
  --environmentpath $TARGET_DIR/environments/ \
  --environment $ENVIRONMENT \
  $TARGET_DIR/environments/$ENVIRONMENT/manifests/site.pp

# todo
# * update provision.sh and bootstrap.sh (?)
