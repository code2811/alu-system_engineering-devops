service { 'apache2':
  ensure => running,
  enable => true,
}

# Ensure wp-config.php exists and has correct permissions
file { '/var/www/html/wp-config.php':
  ensure => file,
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0644',
}

# Fix WordPress file and directory permissions
exec { 'fix-wordpress-permissions':
  command => '/bin/chown -R www-data:www-data /var/www/html && /bin/chmod -R 755 /var/www/html',
  path    => ['/bin', '/usr/bin'],
  unless  => '/usr/bin/test "$(stat -c "%U:%G" /var/www/html)" = "www-data:www-data"',
  require => Service['apache2'],
}

# Ensure PHP is configured correctly
file { '/etc/php5/apache2/php.ini':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  notify  => Service['apache2'],
}

# Restart Apache to ensure configuration takes effect
exec { 'restart-apache':
  command     => '/usr/sbin/service apache2 restart',
  path        => ['/usr/sbin', '/usr/bin'],
  refreshonly => true,
  require     => Exec['fix-wordpress-permissions'],
}
