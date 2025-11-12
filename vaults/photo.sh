#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_YD
set +e

x-utils-mount-vault "$HOME/Documents/Photos" "$MS_YD/_photo"
