## Web Stack Debugging #4

This project focuses on debugging and tuning a web server running Nginx under heavy load.
Using ApacheBench (ab) to simulate high traffic, we initially observed many failed requests due to incorrect Nginx configuration.

The goal is to modify Nginx so it can handle 2000 requests at 100 concurrent connections with 0 failed requests.

# Problem Summary
When benchmarking Nginx with:
`ab -c 100 -n 2000 localhost/`
> We saw:
 - High number of failed requests
 - Length-based errors
 - Slow processing
 - Limited Nginx worker capacity
> Most of these issues were caused by:
 # Root Causes
 - sendfile on;
   Causes incorrect content length when serving files inside containers.
 - Low worker_connections and only 1 worker_process
   Not enough to handle 100 concurrent requests.

## Solution
To solve this, we created a Puppet manifest:
> What the Puppet file does
  - Disables sendfile (prevents length errors)
  - Increases worker connections to 4096 (allows more simultaneous clients)
  - Increases worker processes to 4 (uses more CPU cores)
  - Restarts Nginx to apply changes
These changes eliminate failed requests and fully stabilize the web server.

> Puppet Manifest: 0-the_sky_is_the_limit_not.pp
 # Install puppet and puppet-lint if not installed)
 ```
 apt-get update
 apt-get install -y puppet
 apt-get install -y ruby
 gem install puppet-lint -v 2.1.1
 ```

## Run file:
`puppet apply 0-the_sky_is_the_limit_not.pp`
> Expected out put:
```
Notice: Compiled catalog for <hostname>
Notice: /Stage[main]/Main/Exec[fix--for-nginx]/returns: executed successfully
Notice: Finished catalog run in 1.12 seconds
```

## Expected values innside /etc/nginx/nginx.conf
`grep -E "sendfile|worker" /etc/nginx/nginx.conf`
> Expectedd out put:
```
worker_processes 4;
worker_connections 4096;
sendfile off;
```

# More info:
Run: `ps auxf | grep nginx`

