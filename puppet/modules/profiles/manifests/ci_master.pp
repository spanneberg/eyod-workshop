class profiles::ci_master {

  include ::openjdk8

  $plugins = {
    'credentials'     => { version => '1.24' },
    'ssh-credentials' => { version => '1.11' },
    'git-client'      => { version => '1.19.0' },
    'scm-api'         => { version => '0.2' },
    'git'             => { version => '2.4.0' },
  }

  $users = {
    'admin' => {
      'password'  => 'eyod!admin',
      'full_name' => 'Admin',
      'email'     => 'eyod-admin@example.com',
    },
    'homer' => {
      'password'  => 'eyod!homer',
      'full_name' => 'Homer',
      'email'     => 'eyod-homer@example.com',
    }
  }

  class { '::jenkins' :
    port            => 8080,
    slaveagentport  => 55555,
    executors       => 2,
    plugin_hash     => $plugins,
    user_hash       => $users,
    install_java    => false,
  }

  # to enable slaves via swarm
  class { '::jenkins::master' : }

  Class['openjdk8'] ->
  Class['jenkins']

}
