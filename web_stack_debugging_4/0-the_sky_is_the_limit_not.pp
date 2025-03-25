file_line { 'increase-worker-processes':
  ensure => present,
  path   => '/etc/nginx/nginx.conf',
  match  => '^\s*worker_processes\s+\d+;',
  line   => 'worker_processes auto;',
  notify => Service['nginx'],
}

file_line { 'increase-worker-connections':
  ensure => present,
  path   => '/etc/nginx/nginx.conf',
  match  => '^\s*worker_connections\s+\d+;',
  line   => 'worker_connections 2048;',
  notify => Service['nginx'],
}

# Ensure Nginx service is running
service { 'nginx':
  ensure => running,
  enable => true,
}

# Ensure Nginx configuration is correct
exec { 'test-nginx-config':
  command     => '/usr/sbin/nginx -t',
  refreshonly => true,
  subscribe   => [
    File_line['increase-worker-processes'],
    File_line['increase-worker-connections']
  ],
  notify      => Service['nginx'],
}
