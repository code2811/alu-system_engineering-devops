# Increases Nginx ULIMIT to handle high traffic and eliminate failed requests
exec { 'fix--for-nginx':
  command  => 'sed -i "s/15/4096/" /etc/default/nginx && service nginx restart',
  path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  provider => shell,
}
