#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_YD MS_DOCS
set +e

x-utils-mount-vault "$MS_DOCS" "$MS_YD/_secrets"
x-utils-chmod700 "$MS_DOCS"
