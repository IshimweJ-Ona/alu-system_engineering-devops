## Web Stack Debugging #1

## Project Overview

The goal of this project is to **debug an Ubuntu container’s Nginx installation** and ensure it listens on **port 80 for all active IPv4 IPs**.

---

## Requirements

- Nginx must be installed and running.
- Must listen on port 80 for all server IPv4 addresses.
- Must be configured automatically using a Bash script (`0-nginx_likes_port_80`).
- Script must be executable and pass Shellcheck without errors.
- Script must run without interactive prompts.

## Ececute file:
./0-nginx_likes_port_80

# Test Nginx works:
curl 0:80
