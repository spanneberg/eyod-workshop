class openjdk8 {

  include apt
  
  apt::ppa { 'ppa:openjdk-r/ppa': }

  package { 'openjdk-8-jre' :
    ensure  => installed,
    require => Apt::Ppa['ppa:openjdk-r/ppa'],
  }

}
