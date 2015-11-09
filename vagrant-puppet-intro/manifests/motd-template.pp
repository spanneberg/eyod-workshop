file { '/etc/motd' :
  ensure  => present,
  owner   => root,
  group   => root,
  content => template('/vagrant/templates/motd.erb'),
}