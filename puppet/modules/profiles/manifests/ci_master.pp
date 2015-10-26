class profiles::ci_master {

  class { '::jenkins' :
    executors => 2,
  }

}
