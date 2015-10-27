class profiles::ci_master {

  class { '::jenkins' :
    executors => 2,
  }
  class { '::jenkins::master' : }

  jenkins::plugin { 'credentials':
    version => '1.24',
  }
  jenkins::plugin { 'ssh-credentials':
    version => '1.11',
  }
  jenkins::plugin { 'git-client':
    version => '1.19.0',
  }
  jenkins::plugin { 'scm-api':
    version => '0.2',
  }
  jenkins::plugin { 'git':
    version => '2.4.0',
  }
  jenkins::plugin { 'swarm':
    version => '2.0',
  }

}
