class profiles::sonarqube_server::sonarqube {
  
  class { 'sonarqube' :
    version => '5.1',
    jdbc    => {
      url       => 'jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true',
      username  => 'sonar',
      password  => 'sonar',
    }
  }

}
