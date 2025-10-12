#!/usr/bin/env bash

if [[ -z $MS_CFG ]]; then
    echo "($(basename $0))" "Env var MS_CFG not defined"
    exit 1
fi

if [[ -z $MS_PYTHON_ENV ]]; then
    echo "($(basename $0))" "Env var MS_PYTHON_ENV not defined"
    exit 1
fi

if [[ -z $1 ]]; then
    echo "($(basename $0))" "No venv name passed"
    exit 1
fi

reqs="$MS_CFG/python/$1"

if [[ ! -f "$reqs" ]]; then
    echo "($(basename $0))" "Requirements file not found"
    exit 1
fi

if [[ ! -d $MS_PYTHON_ENV ]]; then
    mkdir -p $MS_PYTHON_ENV
fi

rm -rf "$MS_PYTHON_ENV/$1"

python -m venv "$MS_PYTHON_ENV/$1" && \
source "$MS_PYTHON_ENV/$1/bin/activate" && \
pip install -r $reqs

deactivate

echo "($(basename $0))" "Creating symlink for python interpreter"

sudo rm -f "/usr/local/bin/$1-python" && \
sudo ln -s "$MS_PYTHON_ENV/$1" "/usr/local/bin/$1-python" && \
echo "($(basename $0))" "Created symlink for python interpreter in /usr/local/bin/$1-python"