ll — Task 0: Block all incoming traffic but

This task configures the UFW firewall on `web-01` so that it blocks all incoming traffic except for the following TCP ports:

- **22** (SSH)
- **80** (HTTP)
- **443** (HTTPS/SSL)

Below are the commands used to configure UFW:

```bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
```
We can verify the configuration 
`sudo ufw status verbose`

## NB
If you enable UFW before allowing port 22, you will lock yourself out and lose access to your server.
That's why we allow 22 before running ufw enable
