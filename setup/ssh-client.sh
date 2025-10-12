#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

ssh_crypto="$MS_CFG/ssh"
ssh_home="$HOME/.ssh"

if [[ ! -d $ssh_crypto ]]; then
    echo "($(basename $0))" "Config folder not found"
    exit 1
fi
if [[ -z $1 ]]; then
    echo "($(basename $0))" "Enter folder name for key"
    exit 1
fi

if [[ ! -d $ssh_home ]]; then
    mkdir -m 700 $ssh_home
else
    chmod 700 $ssh_home
fi

if [[ " $* " == *" -c "* ]]; then
    cp -f $ssh_crypto/config $ssh_home/config
    chmod 600 $ssh_home/config
fi

if [[ ! -d "$ssh_crypto/$1" ]]; then
    mkdir "$ssh_crypto/$1"
    ssh-keygen -t rsa -b 4096 -f "$ssh_crypto/$1/ssh-key"
fi

cp -f "$ssh_crypto/$1/ssh-key" "$ssh_home/$1.key"
chmod 600 "$ssh_home/$1.key"


if [[ " $* " == *" -i "* ]]; then
    cp -f "$ssh_crypto/$1/ssh-key" "$ssh_home/id_rsa"
    chmod 600 "$ssh_home/id_rsa"
fi
# echo "  IdentityFile $ssh_home/$1.key" >> $ssh_home/config
