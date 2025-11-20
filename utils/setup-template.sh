#!/usr/bin/env bash

set -e
export cfg="$1"
x-utils-check var $0 cfg MS_SCR
set +e

if [[ -n "$2" ]]; then
    cmd="$2"
else
    cmd="$cfg"
fi

if [[ -n "$3" ]]; then
    dest=".config/$3"
else
    dest=".config/$cfg"
fi

if x-utils-check var $0 MS_CFG &> /dev/null && x-utils-check dir $0 "$MS_CFG" &> /dev/null; then
    mkdir -p "$MS_CFG/$cfg"
    touch "$MS_CFG/$cfg/.foolproof"
fi

scr="$MS_SCR/setup/$cfg.sh"
if x-utils-check path $0 "$scr" &> /dev/null; then
    echo "$(basename $0): Setup script "$scr" already exists"
    exit 0
fi

cat >> "$scr" <<EOF
#!/usr/bin/env bash
export SETUP_CFG="$cfg"
CMD="$cmd"
EOF

echo -n 'DEST="$HOME/' >> "$scr"
echo "$dest\"" >> "$scr"
cat >> "$scr" <<'EOF'

set -e
export config_fld=$(x-utils-cfg-get-path $@)
x-utils-check var $0 config_fld
x-utils-cmd-install $CMD
x-utils-cfg-install $config_fld $DEST "$@"
set +e
EOF


