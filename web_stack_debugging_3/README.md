## Web Stack Debugging Project
# Overview
> This project demonstrates debugging a LAMP (Linux, Apache, MySQL, PHP) stack running WordPress on Ubuntu 14.04 (Trusty). The goal is to fix common issues such as:
- 500 Internal Server Error on WordPress pages
- Incorrect file ownership and permissions
- Missing PHP modules
- Apache service misconfiguration

## Debugging Steps
1. Check Apache processes
`ps auxf | grep apache2`
- Confirm Apache processes are running.

2. Check Apache error logs
`tail -f /var/log/apache2/error.log`. Look for errors indicating misconfiguration or missing PHP modules. 

3. Test PHP syntax
`php -l /var/www/html/index.php`. Ensure php files do not have syntax errors.

4. Verify PHP modules
`php -m`. For this task check if curl and gd are installed.

5. Verify database connection
``
`php -r ' $conn = new mysqli("localhost", "holberton", "holberton", "wordpress"); if ($conn->connect_error) { die("Connection failed: " . $conn->connect_error); } else { echo "Connected successfully\n"; } $conn->close(); '
```
- This confirms that WordPress can connect to the mysql database.

6. Check WordPress configuration
`grep DB_ /var/www/html/wp-config.php`

- The file `0-strace_is_your_friend.pp`

> What it does:
- Installs necessary PHP modules (curl, gd) for WordPress themes and plugins.
- Sets ownership of /var/www/html to www-data.
- Ensures directories have 755 permissions and files 644.
- Makes sure Apache is running and enabled to start at boot.

> WordPress Debugging

To see PHP errors directly in the browser, the following lines were added to `/var/www/html/wp-config.php`:
```
define('WP_DEBUG', true);
define('WP_DEBUG_DISPLAY', true);
ini_set('display_errors', 1);
```
