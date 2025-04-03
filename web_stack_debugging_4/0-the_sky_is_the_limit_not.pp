# Puppet manifest to increase Nginx performance under high load
# Fix for benchmarking issue where 943 out of 2000 requests were failing

# Increase the ULIMIT for the Nginx service
exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx && service nginx restart',
  path    => '/usr/local/bin/:/bin/:/usr/bin/:/usr/sbin/',
}

# Alternative approach could include updating the Nginx configuration directly:
# file { '/etc/nginx/nginx.conf':
#   ensure  => present,
#   content => template('nginx/nginx.conf.erb'),
#   notify  => Service['nginx'],
# }
# 
# service { 'nginx':
#   ensure  => running,
#   enable  => true,
#   require => File['/etc/nginx/nginx.conf'],
# }
