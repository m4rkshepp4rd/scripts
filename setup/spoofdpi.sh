#!/usr/bin/env bash

DESKTOP_ENTRY_NAME="spoofdpi.desktop"
DESKTOP_ENTRY_TMP="/tmp/${DESKTOP_ENTRY_NAME}"
LOCAL_PATH="$HOME/.spoofdpi"

rm -rf $LOCAL_PATH
rm ${DESKTOP_ENTRY_TMP}
rm $HOME/.config/autostart/${DESKTOP_ENTRY_NAME}

curl -fsSL https://raw.githubusercontent.com/xvzc/SpoofDPI/main/install.sh | bash -s linux-amd64

cat > $DESKTOP_ENTRY_TMP <<EOF
[Desktop Entry]
Exec=$LOCAL_PATH/bin/spoofdpi --addr \"127.0.0.2\" &
Type=Application
Name=spoofdpi.desktop
Terminal=false
EOF

cp ${DESKTOP_ENTRY_TMP} $HOME/.config/autostart
rm ${DESKTOP_ENTRY_TMP}


echo "($(basename $0))" "Installed in $LOCAL_PATH"