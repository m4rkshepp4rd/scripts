#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_BROWSER
set +e

cryptopro_link="https://cryptopro.ru/sites/default/files/private/csp/50/13000/linux-amd64.tgz"

$MS_BROWSER $cryptopro_link