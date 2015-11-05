class profiles::sonarqube_server::db {

  class { "mysql::server" :
    databases => {
      'sonar' => {
        ensure  => 'present',
        charset => 'utf8',
      }
    },
    users => {
      "sonar@localhost" => {
        ensure => 'present',
        password_hash => mysql_password('sonar'),
      }
    },
    grants => {
      "sonar@localhost/sonar.*" => {
        ensure     => 'present',
        options    => ['GRANT'],
        privileges => ['ALL'],
        table      => "sonar.*",
        user       => "sonar@localhost",
      }
    }
  }
  
}
