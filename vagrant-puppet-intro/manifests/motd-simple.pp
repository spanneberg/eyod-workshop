file { '/etc/motd' :
  ensure  => present,
  owner   => root,
  group   => root,
  content => 'My special MOTD provisioned by Puppet!'
}
