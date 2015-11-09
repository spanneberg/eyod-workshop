class openjdk8 {

  include apt
 
  apt::ppa { 'ppa:openjdk-r/ppa':
	notify=> Exec[apt-update],
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
  }

  # remove openjdk7 if present
  package { [ 'openjdk-7-jdk', 'openjdk-7-jre', 'openjdk-7-jre-headless' ] :
    ensure => absent,
  }

  package { 'openjdk-8-jdk' :
    ensure  => installed,
    require => Apt::Ppa['ppa:openjdk-r/ppa'],
  }

}
