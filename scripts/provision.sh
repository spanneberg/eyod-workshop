#!/bin/sh

# check if we run in dev or prod environment and update infra code if we are in prod
if [ $(getent passwd vagrant) ]; then
  ENVIRONMENT=dev
else
  ENVIRONMENT=production
fi

echo "$(date +%T): Starting provisiong for $(hostname)/$(hostname -i) in environment ${ENVIRONMENT}"

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

# run r10k
echo "Running r10k for shared dependencies ..."
$( cd $TARGET_DIR/r10k && r10k puppetfile install )

echo "Running r10k for environment ($ENVIRONMENT) dependencies ..."
$( cd $TARGET_DIR/environments/$ENVIRONMENT/r10k && r10k puppetfile install )

# apply puppet manifests
echo "Running Puppet ..."
/opt/puppetlabs/bin/puppet apply \
  --codedir /opt/puppet \
  --environment $ENVIRONMENT \
  --detailed-exitcodes \
  $TARGET_DIR/environments/$ENVIRONMENT/manifests/site.pp
  #--hiera_config=$TARGET_DIR/hiera/hiera.yaml \
  #--environmentpath $TARGET_DIR/environments/ \

# only update provisioning script if not in dev environment, otherwise local dev version gets overwritten
echo "Updating provisioning script ..."
if [ "$ENVIRONMENT" != "dev" ]; then
  curl https://raw.githubusercontent.com/spanneberg/eyod-workshop/master/scripts/provision.sh > /bin/provision.sh
else
  cp /vagrant/scripts/provision.sh /bin/provision.sh
fi
chmod +x /bin/provision.sh

echo "$(date +%T): Finished provisiong for $(hostname)/$(hostname -i)"
