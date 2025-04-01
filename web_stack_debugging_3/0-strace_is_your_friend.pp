# Fixes Apache 500 error by correcting typo in WordPress configuration file
exec { 'fix-wordpress':
  command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  onlyif  => 'test -f /var/www/html/wp-settings.php && grep -q phpp /var/www/html/wp-settings.php',
}
