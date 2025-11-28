# Ensure Apache can read and serve the web files by fixing ownership and permissions for /var/www/html

exec { 'chown-www-data':
  command  => '/bin/chown -R www-data:www-data /var/www/html',
  onlyif   => 'test "$(stat -c %U /var/www/html 2>/dev/null)" != "www-data"',
  path     => ['/bin', '/usr/bin'],
}

exec { 'fix-permissions':
  command  => '/bin/bash -c "find /var/www/html -type d -exec chmod 0755 {} \\; && find /var/www/html -type f -exec chmod 0644 {} \\;"',
  onlyif   => 'test -d /var/www/html',
  path     => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  require  => Exec['chown-www-data'],
}

service { 'apache2':
  ensure     => running,
  enable     => true,
  subscribe  => [Exec['chown-www-data'], Exec['fix-permissions']],
}

