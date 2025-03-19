#!/bin/bash

# Update the package list
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Create the HTML page with "Holberton School"
echo "Holberton School" | sudo tee /var/www/html/index.html

# Ensure Nginx is running and accepting traffic on port 80
sudo systemctl start nginx
sudo systemctl enable nginx

# Allow traffic on port 80 through the firewall (if UFW is enabled)
sudo ufw allow 'Nginx HTTP'

# Restart Nginx to apply any changes
sudo systemctl restart nginx

# Print the status of Nginx to confirm it's running
sudo systemctl status nginx

