class profiles::artifact_repo {
  
  class { 'openjdk8' : }
  
  class { 'artifactory::config' :
    version       => '4.2.0',
    port          => 9090,
    manage_java   => false,
  }
  
  class { 'artifactory' : }

  Class['openjdk8'] -> Class['Artifactory::Install']
  
}
