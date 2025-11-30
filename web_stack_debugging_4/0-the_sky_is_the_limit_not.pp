# This manifest fixes Nginx to handle high traffic with zero failed requests

exec { 'set nginx ulimit':
  command => 'grep -q "^ULIMIT=10000" /etc/default/nginx || echo "ULIMIT=10000" >> /etc/default/nginx',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

exec { 'restart nginx':
  command => 'service nginx restart',
  refreshonly => true,
  subscribe   => Exec['set nginx ulimit'],
  path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

