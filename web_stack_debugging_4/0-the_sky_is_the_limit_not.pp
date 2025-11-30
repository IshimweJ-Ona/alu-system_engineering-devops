# This manifest fixes Nginx under heavy load by disabling sendfile and increasing worker connections

exec { 'fix--for-nginx':
  command => 'sed -i "s/sendfile on;/sendfile off;/" /etc/nginx/nginx.conf &&
              sed -i "s/worker_connections [0-9]*/worker_connections 4096/" /etc/nginx/nginx.conf &&
              sed -i "s/worker_processes [0-9]*/worker_processes 4/" /etc/nginx/nginx.conf &&
              service nginx restart',
  path    => ['/bin', '/usr/bin'],
}

