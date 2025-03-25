# Puppet manifest to fix WordPress 500 Internal Server Error

# Ensure Apache is running
service { 'apache2':
  ensure => running,
  enable => true,
}

# Fix file permissions for WordPress directories
file { ['/var/www/html', '/var/www/html/wp-admin', '/var/www/html/wp-content']:
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  recurse => true,
  mode    => '0755',
}

# Ensure PHP configuration is correct
exec { 'fix-wordpress':
  command => '/bin/chmod 755 /var/www/html/wp-*.php',
  unless  => '/usr/bin/test "$(stat -c "%a %U" /var/www/html/wp-config.php)" = "755 www-data"',
  require => Service['apache2'],
}
