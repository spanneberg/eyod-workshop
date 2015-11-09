package { 'nginx' :
  ensure => installed,
}

service { 'nginx' :
  ensure  => running,
  require => Package['nginx'],
}

file { '/usr/share/nginx/html/index.html' :
  content => template('/vagrant/templates/index.html.erb'),
}
