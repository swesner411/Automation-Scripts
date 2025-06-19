#!/bin/bash

# Get available updates
sudo apt update

# Download and install available updates
sudo apt upgrade -y

# Remove unnecessary packages
sudo apt autoremove

# Clean the cache
sudo apt autoclean

# Reboot the host
sudo reboot
