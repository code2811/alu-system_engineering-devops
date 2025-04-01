# 0-the_sky_is_the_limit_not.pp
exec { 'increase_nginx_limits':
  command => 'sed -i "s/worker_connections [0-9]\+;/worker_connections 5000;/" /etc/nginx/nginx.conf && \
             sed -i "s/worker_processes [0-9]\+;/worker_processes auto;/" /etc/nginx/nginx.conf && \
             echo "events { worker_connections 5000; }" >> /etc/nginx/nginx.conf && \
             echo "ulimit -n 10000" >> /etc/default/nginx && \
             service nginx restart',
  path    => '/bin:/usr/bin:/usr/sbin',
  unless  => 'grep -q "worker_connections 5000" /etc/nginx/nginx.conf',
}

exec { 'increase_system_limits':
  command => 'echo "* soft nofile 10000" >> /etc/security/limits.conf && \
             echo "* hard nofile 10000" >> /etc/security/limits.conf && \
             echo "root soft nofile 10000" >> /etc/security/limits.conf && \
             echo "root hard nofile 10000" >> /etc/security/limits.conf',
  path    => '/bin:/usr/bin:/usr/sbin',
  unless  => 'grep -q "soft nofile 10000" /etc/security/limits.conf',
}}
