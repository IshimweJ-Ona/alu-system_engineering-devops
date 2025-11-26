## Web Stack Debugging #2

This project is part of the ALU System Engineering & DevOps curriculum.
Its goal is to practice debugging and fixing web stack issues inside Linux containers.

# The tasks focus on:

Running commands as another user

Configuring Nginx to run under a non-root user

Understanding privilege separation and improving security practices

# Tasks 
0. Run software as another user

Write a Bash script that:

Accepts one argument (a username)

Runs whoami as the provided user using the appropriate command

Demonstrates privilege separation in Linux

File:
`0-iamsomeoneelse`

1. Run Nginx as nginx

By default, Nginx runs as root, which is a security risk.
Fix the container so that:

Nginx runs as the nginx user

It listens on port 8080 instead of 80

No removal of Nginx is allowed

Write a script to apply the required configuration changes.

File:
`1-run_nginx_as_ngin

To confirm Nginx is running correctly:
```
ps aux | grep nginx
nc -z 0 8080
```
