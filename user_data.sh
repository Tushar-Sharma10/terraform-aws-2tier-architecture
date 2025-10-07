#!/bin/bash
# USER DATA SCRIPT FOR UBUNTU EC2 INSTANCES

# Update all packages
apt-get update -y
apt-get upgrade -y

# Install Nginx
apt-get install nginx -y

# Enable Nginx to start on boot
systemctl enable nginx

# Start Nginx service
systemctl start nginx

# Deploy a simple HTML page
cat <<EOF > /var/www/html/index.html
<html>
  <head>
    <title>Welcome to My Web App</title>
  </head>
  <body>
    <h1>Hello from EC2 instance in 2-tier architecture!</h1>
    <p>Environment: Development </p>
  </body>
</html>
EOF

