#!/usr/bin/env bash

set -e
x-utils-check var $0 MS_LOCAL_BIN
set +e

shortcuts_path="$MS_LOCAL_BIN/x-shortcuts"

show_menu() {
    echo "======================"
    echo "      SHORTCUTS"
    echo "======================"
    echo "z. Work Bookmarks"
    echo "j. Jira Search"
    echo "w. Confluence Search"
    echo "x. fzfx"
    echo "c. fzfc"
    echo "d. fzfd"
    echo "v. fzfv"
    echo "======================"
}

show_menu
read -n 1 -s choice

case $choice in
    z)
        $shortcuts_path-fzf-url $VZ_WORK_BOOKMARKS $VZ_WORK_BROWSER
        ;;
    j)
        $shortcuts_path-fzf-url-preview $VZ_JIRA_INDEX $VZ_WORK_BROWSER
        ;;
    w)
        $shortcuts_path-fzf-url-preview $VZ_CONFL_INDEX $VZ_WORK_BROWSER
        ;;
    x)
        $shortcuts_path-fzfx
        ;;
    c)
        $shortcuts_path-fzfc
        ;;
    d)
        $shortcuts_path-fzfd
        ;;
    v)
        $shortcuts_path-fzfv
        ;;
    *)
        exit 1
        ;;
esac

exit 0