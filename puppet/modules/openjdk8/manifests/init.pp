class openjdk8 {

  include apt
  
  apt::ppa { 'ppa:openjdk-r/ppa': }

  # remove openjdk7 if present
  package { [ 'openjdk-7-jdk', 'openjdk-7-jre', 'openjdk-7-jre-headless' ] :
    ensure => absent,
  }

  package { 'openjdk-8-jre' :
    ensure  => installed,
    require => Apt::Ppa['ppa:openjdk-r/ppa'],
  }

}
