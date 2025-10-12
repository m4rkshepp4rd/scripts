#!/usr/bin/env bash


custom_keys="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['$custom_keys/naulitus/',\
'$custom_keys/flameshot/',\
'$custom_keys/flameshot-copy/',\
'$custom_keys/copyq/',\
'$custom_keys/telegram/',\
'$custom_keys/my-browser/',\
'$custom_keys/work-browser/',\
'$custom_keys/work-bookmarks/',\
'$custom_keys/jira-search/',\
'$custom_keys/confluence-search/',\
'$custom_keys/fzfc/',\
'$custom_keys/fzfx/',\
'$custom_keys/fzfd/',\
'$custom_keys/fzfv/',\
'$custom_keys/terminal/',\
'$custom_keys/monitor/']"
# '$custom_keys/envoker/',\
# Nautilus
dconf write "$custom_keys/naulitus/binding" "'<Super>e'"
dconf write "$custom_keys/naulitus/command" "'nautilus --new-window'"
dconf write "$custom_keys/naulitus/name" "'naulitus'"
# Flameshot
dconf write "$custom_keys/flameshot/binding" "'Print'"
dconf write "$custom_keys/flameshot/command" "'script --command \"WAYLAND_DISPLAY=wayland-1 flameshot gui --delay 100 --raw | wl-copy\"'"
dconf write "$custom_keys/flameshot/name" "'flameshot'"
dconf write "$custom_keys/flameshot-copy/binding" "'<Super>Print'"
dconf write "$custom_keys/flameshot-copy/command" "'script --command \"WAYLAND_DISPLAY=wayland-1 flameshot gui --delay 100\"'"
dconf write "$custom_keys/flameshot-copy/name" "'flameshot-copy'"
# Telegram
dconf write "$custom_keys/telegram/binding" "'<Super>3'"
dconf write "$custom_keys/telegram/command" "'Telegram'"
dconf write "$custom_keys/telegram/name" "'telegram'"
# my-browser
dconf write "$custom_keys/my-browser/binding" "'<Super><Alt>b'"
dconf write "$custom_keys/my-browser/command" "'$MS_BROWSER'"
dconf write "$custom_keys/my-browser/name" "'my-browser'"
# work-browser
dconf write "$custom_keys/work-browser/binding" "'<Super><Alt>z'"
dconf write "$custom_keys/work-browser/command" "'$VZ_WORK_BROWSER'"
dconf write "$custom_keys/work-browser/name" "'work-browser'"
# copyq
dconf write "$custom_keys/copyq/binding" "'<Super><Alt>v'"
dconf write "$custom_keys/copyq/command" "'copyq show'"
dconf write "$custom_keys/copyq/name" "'copyq'"
# Work bookmarks
dconf write "$custom_keys/work-bookmarks/binding" "'<Super>z'"
dconf write "$custom_keys/work-bookmarks/command" "'gnome-terminal --window-with-profile=work-bookmarks'"
dconf write "$custom_keys/work-bookmarks/name" "'work-bookmarks'"
# Jira search
dconf write "$custom_keys/jira-search/binding" "'<Super>0'"
dconf write "$custom_keys/jira-search/command" "'gnome-terminal --window-with-profile=jira-search'"
dconf write "$custom_keys/jira-search/name" "'jira-search'"
# Confluence search
dconf write "$custom_keys/confluence-search/binding" "'<Super>9'"
dconf write "$custom_keys/confluence-search/command" "'gnome-terminal --window-with-profile=confluence-search'"
dconf write "$custom_keys/confluence-search/name" "'confluence-search'"
# fzfc
dconf write "$custom_keys/fzfc/binding" "'<Super>c'"
dconf write "$custom_keys/fzfc/command" "'gnome-terminal --window-with-profile=fzfc'"
dconf write "$custom_keys/fzfc/name" "'fzfc'"
# fzfx
dconf write "$custom_keys/fzfx/binding" "'<Super>x'"
dconf write "$custom_keys/fzfx/command" "'gnome-terminal --window-with-profile=fzfx'"
dconf write "$custom_keys/fzfx/name" "'fzfx'"
# fzfd
dconf write "$custom_keys/fzfd/binding" "'<Super>d'"
dconf write "$custom_keys/fzfd/command" "'gnome-terminal --window-with-profile=fzfd'"
dconf write "$custom_keys/fzfd/name" "'fzfd'"
# fzfv
dconf write "$custom_keys/fzfv/binding" "'<Super>v'"
dconf write "$custom_keys/fzfv/command" "'gnome-terminal --window-with-profile=fzfv'"
dconf write "$custom_keys/fzfv/name" "'fzfv'"
# envoker
# dconf write "$custom_keys/envoker/binding" "'<Super>d'"
# dconf write "$custom_keys/envoker/command" "'gnome-terminal --window-with-profile=envoker'"
# dconf write "$custom_keys/envoker/name" "'envoker'"
# Terminal
dconf write "$custom_keys/terminal/binding" "'<Super>2'"
dconf write "$custom_keys/terminal/command" "'gnome-terminal'"
dconf write "$custom_keys/terminal/name" "'terminal'"
# Monitor
dconf write "$custom_keys/monitor/binding" "'<Super><Alt>x'"
dconf write "$custom_keys/monitor/command" "'gnome-system-monitor'"
dconf write "$custom_keys/monitor/name" "'monitor'"

legacy_keys="/org/gnome/terminal/legacy/keybindings"
dconf write "$legacy_keys/copy" "'<Primary>c'"
dconf write "$legacy_keys/paste" "'<Primary>v'"
dconf write "$legacy_keys/new-tab" "'<Primary>t'"
dconf write "$legacy_keys/close-tab" "'<Primary>w'"


# Treminal profiles
dconf_terminal_path="/org/gnome/terminal/legacy/profiles:"
shortcuts_path="$MS_LOCAL_BIN/x-shortcuts"

work_bookmarks_uuid="4298f0d9-56b0-42f6-a54b-b7762a00e4d4"
jira_search_uuid="57a0c42c-0456-4061-b59f-6dbc94386109"
confluence_search_uuid="2bafa996-4feb-48a0-8068-41399305442d"
fzfx_uuid="0c98efc5-a99b-4e4e-98ac-c92340b705b1"
fzfc_uuid="188045e0-45f1-44ee-a81b-d90ecf30813f"
fzfd_uuid="8cb6e0b7-96ae-4223-b9fc-b215d88556f8"
fzfv_uuid="f9d175ab-4e5d-4aa4-9e3b-8ea24f68d637"
# reserved="8bd91592-5df4-48e6-bb77-8049bdee524a"
# reserved="ee501059-ab00-4539-a5b3-18cc00024f8a"
# reserved="bf89274c-b1be-4825-867e-4cba8dcb2c65"
# reserved="6342b799-bc3b-4ddf-b260-e6abd3fa6b45"
# reserved="89ccd19e-b553-460a-b2d2-2f2385e24727"
# reserved="5f54a687-112f-4452-8714-c6bca95990d2"
# reserved="5f8c8b54-2538-436a-9ebc-81730c5bf429"
# reserved="6802c1e9-6252-4fd3-89a9-32778404af82"
# reserved="6f7df6a9-7a7a-49aa-bdab-8ef094ddf7bc"
# reserved="799f3239-ecdf-4a5d-bd60-1e97671831d6"
# envoke_uuid="7420f070-6951-4472-ac5b-7f1753f10098"

# DO NOT CHANGE!!! Used in gnome-main.sh
base_profile_uuid="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"

dconf write "$dconf_terminal_path/list" "['$base_profile_uuid','$work_bookmarks_uuid','$fzfx_uuid','$fzfc_uuid','$fzfd_uuid','$fzfv_uuid', '$jira_search_uuid', '$confluence_search_uuid']"
# dconf write "$dconf_terminal_path/list" "['$base_profile_uuid','$envoke_uuid']"
dconf write "$dconf_terminal_path/default" "'$base_profile_uuid'"
dconf write "$dconf_terminal_path/:$base_profile_uuid/visible-name" "'base-profile'"

dconf write "$dconf_terminal_path/:$work_bookmarks_uuid/visible-name" "'work-bookmarks'"
dconf write "$dconf_terminal_path/:$work_bookmarks_uuid/use-custom-command" "true"
dconf write "$dconf_terminal_path/:$work_bookmarks_uuid/custom-command" "'bash -i $shortcuts_path-fzf-url $VZ_WORK_BOOKMARKS $VZ_WORK_BROWSER'"

dconf write "$dconf_terminal_path/:$jira_search_uuid/visible-name" "'jira-search'"
dconf write "$dconf_terminal_path/:$jira_search_uuid/use-custom-command" "true"
dconf write "$dconf_terminal_path/:$jira_search_uuid/custom-command" "'bash -i $shortcuts_path-fzf-url-preview $VZ_JIRA_INDEX $VZ_WORK_BROWSER'"

dconf write "$dconf_terminal_path/:$confluence_search_uuid/visible-name" "'confluence-search'"
dconf write "$dconf_terminal_path/:$confluence_search_uuid/use-custom-command" "true"
dconf write "$dconf_terminal_path/:$confluence_search_uuid/custom-command" "'bash -i $shortcuts_path-fzf-url-preview $VZ_CONFL_INDEX $VZ_WORK_BROWSER'"

dconf write "$dconf_terminal_path/:$fzfx_uuid/visible-name" "'fzfx'"
dconf write "$dconf_terminal_path/:$fzfx_uuid/use-custom-command" "true"
dconf write "$dconf_terminal_path/:$fzfx_uuid/custom-command" "'bash -i $shortcuts_path-fzfx'"

dconf write "$dconf_terminal_path/:$fzfc_uuid/visible-name" "'fzfc'"
dconf write "$dconf_terminal_path/:$fzfc_uuid/use-custom-command" "true"
dconf write "$dconf_terminal_path/:$fzfc_uuid/custom-command" "'bash -i $shortcuts_path-fzfc'"

dconf write "$dconf_terminal_path/:$fzfd_uuid/visible-name" "'fzfd'"
dconf write "$dconf_terminal_path/:$fzfd_uuid/use-custom-command" "true"
dconf write "$dconf_terminal_path/:$fzfd_uuid/custom-command" "'bash -i $shortcuts_path-fzfd'"

dconf write "$dconf_terminal_path/:$fzfv_uuid/visible-name" "'fzfv'"
dconf write "$dconf_terminal_path/:$fzfv_uuid/use-custom-command" "true"
dconf write "$dconf_terminal_path/:$fzfv_uuid/custom-command" "'bash -i $shortcuts_path-fzfv'"

# dconf write "$dconf_terminal_path/:$envoke_uuid/visible-name" "'envoker'"
# dconf write "$dconf_terminal_path/:$envoke_uuid/use-custom-command" "true"
# dconf write "$dconf_terminal_path/:$envoke_uuid/custom-command" "'bash -i $shortcuts_path-envoker'"

