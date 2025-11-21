#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_YD MS_DOCS
set +e

x-utils-mount-vault "$MS_DOCUMENTS" "$MS_YD/_docs"
