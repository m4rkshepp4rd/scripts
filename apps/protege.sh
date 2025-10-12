#!/usr/bin/env bash

if [[ -z $1 ]]; then
    PROTEGE_LINK="https://github.com/protegeproject/protege-distribution/releases/download/protege-5.6.4/Protege-5.6.4-linux.tar.gz"
else
    PROTEGE_LINK=$1
fi

PROTEGE_LOCAL_PATH="$HOME/Protege-5.6.4"
PROTEGE_TAR="/tmp/protege.tar.gz"
PROTEGE_DESKTOP_NAME="protege.desktop"
PROTEGE_DESKTOP_TMP="/tmp/$PROTEGE_DESKTOP_NAME"

sudo rm -rf $PROTEGE_LOCAL_PATH
rm $PROTEGE_TAR
rm $PROTEGE_DESKTOP_TMP

curl -L -o $PROTEGE_TAR $PROTEGE_LINK
sudo tar xfz $PROTEGE_TAR -C $HOME

if [[ $? != 0 ]]; then
    rm $PROTEGE_DESKTOP_TMP
    rm $PROTEGE_TAR
    exit 1
fi

cat > $PROTEGE_DESKTOP_TMP <<EOF
[Desktop Entry]
Exec=sh $PROTEGE_LOCAL_PATH/run.sh %f
Type=Application
Name=Protege
Terminal=false
Icon=$PROTEGE_LOCAL_PATH/app/Protege.ico
EOF

sudo rm /usr/share/applications/$PROTEGE_DESKTOP_NAME
sudo cp $PROTEGE_DESKTOP_TMP /usr/share/applications
rm $PROTEGE_DESKTOP_TMP
rm $PROTEGE_TAR

echo "($(basename $0))" "Installed in $PROTEGE_LOCAL_PATH"