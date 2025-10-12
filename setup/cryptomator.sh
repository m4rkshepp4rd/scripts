#!/usr/bin/env bash

paru -Sy cryptomator-bin
cp /usr/share/applications/org.cryptomator.Cryptomator.desktop $HOME/.config/autostart
