class profiles::ci_slave {
  
  include ::openjdk8
  # configuration of Jenkins slave via hiera
  include ::jenkins::slave

  # class ordering
  Class['openjdk8'] ->
  Class['jenkins::slave']

}
