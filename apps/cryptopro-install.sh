#!/usr/bin/env bash

cryptopro_tar="$HOME/Downloads/linux-amd64.tgz"
cryptopro_aur_path="$HOME/Downloads/cryptopro-csp-k1"
cryptopro_git="https://aur.archlinux.org/cryptopro-csp-k1.git"

if [[ ! -z $1 && -f $1 ]]; then
    cryptopro_tar=$1
fi

cryptopro_tar=$(realpath $cryptopro_tar)

if [[ ! -f $cryptopro_tar ]]; then
    echo "($(basename $0))" "file not found"
    exit 1
fi

tar_base=$(basename $cryptopro_tar)
tar_name="${tar_base%.*}" 

paru -Rns cryptopro-csp-k1

license_ini="/etc/opt/cprocsp/license.ini"
if [[ -f $license_ini ]]; then
    sudo rm -f $license_ini
fi


patch_pkgbuild() {
    shasha=$(sha256sum $tar_base | cut -d " " -f 1)
    sed -i "/sha256sums/c\sha256sums=('$shasha')" PKGBUILD
    tar -xf $tar_base
    
    pkgver=$(find $tar_name/lsb-cprocsp-base* | head -n 1 | xargs basename | grep -oE '[0-9]+\.[0-9]+\.[0-9]+-[0-9]+')
    sed -i "/_pkgver=/c\_pkgver=\"$pkgver\"" PKGBUILD

    cadesver=$(find $tar_name/cprocsp-pki-cades-64-* | head -n 1 | xargs basename | grep -oE '[0-9]+\.[0-9]+\.[0-9]+-[0-9]+')    
    sed -i "/_cades_version=/c\_cades_version=\"$cadesver\"" PKGBUILD
}

git clone --depth=1 $cryptopro_git $cryptopro_aur_path

cp $cryptopro_tar $cryptopro_aur_path && \
cd $cryptopro_aur_path && \
patch_pkgbuild && \
makepkg -si && \
rm $cryptopro_tar && \
rm -rf $cryptopro_aur_path
