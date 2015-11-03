class roles::ci_slave_and_sonarqube {

  include ::profiles::ci_slave
  include ::profiles::sonarqube_server

}
