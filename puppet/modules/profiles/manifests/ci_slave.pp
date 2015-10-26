class profiles::ci_slave {
  
  class { '::jenkins::slave' :
    masterurl => 'http://192.168.33.21:8080',
    # ui_user => 'adminuser',
    # ui_pass => 'adminpass',
  }

}
