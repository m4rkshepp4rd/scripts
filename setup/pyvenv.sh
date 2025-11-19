#!/usr/bin/env bash

export SETUP_CFG="pyvenvs"
DEST="$HOME"

set -e
export reqs=$(x-utils-cfg-get-path $@)
x-utils-check var $0 reqs MS_PYTHON_ENV
x-utils-check file $0 "$reqs"
set +e

if [[ ! -d "$MS_PYTHON_ENV" ]]; then
    mkdir -p "$MS_PYTHON_ENV"
fi

profile="${reqs##*/}"
profile_env="$MS_PYTHON_ENV/$profile"

rm -rf "$profile_env"

python -m venv "$profile_env" && \
source "$profile_env/bin/activate" && \
pip install -r $reqs

deactivate

echo "$(basename $0): creating symlink for python interpreter"

sudo rm -f "/usr/local/bin/$profile-python" && \
sudo ln -s "$profile_env" "/usr/local/bin/$profile-python" && \
echo "$(basename $0): сreated symlink for python interpreter in /usr/local/bin/$profile-python"
