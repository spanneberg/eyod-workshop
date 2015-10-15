class roles::git_repo_server {

  file { "/tmp/blafasel" :
    ensure => present,
  }


  class { 'gitlab':
    external_url => 'http://gitlab.local',
  }

}
