# Load Balancer Project

This project focuses on configuring multiple web servers behind a load balancer, with custom HTTP response headers to track which server is serving requests. It also includes automating the setup using Bash scripts.

## Tasks

### 0. Double the Number of Webservers

**Objective:**  
Configure `web-02` to be identical to `web-01` and ensure Nginx includes a custom HTTP response header.

**Requirements:**

- Configure Nginx on both `web-01` and `web-02`.
- Add a custom HTTP header: `X-Served-By`.
- The value of the header must be the server's hostname.
- Automate the configuration with the script `0-custom_http_response_header`.
- Ignore SC2154 warnings for shellcheck.

**Example:**

```bash
$ curl -sI 34.198.248.145 | grep X-Served-By
X-Served-By: 03-web-01

$ curl -sI 54.89.38.100 | grep X-Served-By
X-Served-By: 03-web-02

