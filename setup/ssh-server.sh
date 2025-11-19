#!/usr/bin/env bash

rm -rf $HOME/.ssh
mkdir -m 700 $HOME/.ssh

touch $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/authorized_keys

sudo nano /etc/ssh/sshd_config
sudo systemctl start sshd
sudo systemctl enable sshd
