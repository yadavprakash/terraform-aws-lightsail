#!/bin/bash

sudo sudo apt-get update -y
sudo apt-get update install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

