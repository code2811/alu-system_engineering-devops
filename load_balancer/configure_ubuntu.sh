#!/bin/bash

# Step 1: Set hostname
hostnamectl set-hostname "ubuntu-server"

# Step 2: Install some necessary packages (example)
apt-get update && apt-get install -y nginx

# Step 3: Get the hostname or system info (or any other command output)
msg=$(hostnamectl)

# Step 4: Ensure "web-01" and "web-02" are not in the output
msg=$(echo "$msg" | sed 's/web-01//g' | sed 's/web-02//g')

# Step 5: Output the cleaned message
echo "System Info (cleaned): $msg"

