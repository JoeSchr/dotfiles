#! /bin/bash

# start service
systemctl enable --now zerotier-one
# sudo /usr/sbin/zerotier-one -d
# join network
sudo zerotier-cli join 1d71939404630533

