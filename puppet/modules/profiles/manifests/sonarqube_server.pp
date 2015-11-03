class profiles::sonarqube_server {

  include ::openjdk8
  include ::profiles::sonarqube_server::db
  include ::profiles::sonarqube_server::sonarqube

  # class ordering
  Class['openjdk8'] ->
  Class['profiles::sonarqube_server::db'] ->
  Class['profiles::sonarqube_server::sonarqube']

}
