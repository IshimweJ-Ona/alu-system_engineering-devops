# Ensure Apache can read and serve the web files by fixing ownership and permissions for /var/www/html
# This manifest:
#  - ensures web files are owned by www-data
#  - sets directory permissions to 755 and file permissions to 644
#  - ensures apache2 service is enabled and running
# Ensure required PHP extensions are installed
package { ['php5-curl', 'php5-gd']:
  ensure => installed,
  provider => 'apt',
}

# Ensure Apache can read and serve the web files
exec { 'chown-www-data':
  command => '/bin/chown -R www-data:www-data /var/www/html',
  onlyif  => 'test "$(stat -c %U /var/www/html 2>/dev/null)" != "www-data"',
  path    => ['/bin', '/usr/bin'],
}

exec { 'fix-permissions':
  command => '/bin/bash -c "find /var/www/html -type d -exec chmod 0755 {} \\; && find /var/www/html -type f -exec chmod 0644 {} \\;"',
  onlyif  => 'test -d /var/www/html',
  path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  require => Exec['chown-www-data'],
}

# Ensure Apache service is running and enabled
# Also restart if PHP packages are installed or permissions are fixed
service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => [
    Package['php5-curl', 'php5-gd'],
    Exec['chown-www-data'],
    Exec['fix-permissions'],
  ],
}

