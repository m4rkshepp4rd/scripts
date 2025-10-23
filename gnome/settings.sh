#!/usr/bin/env bash


# Window management

mutter="org.gnome.mutter"
gsettings set "$mutter" edge-tiling false
gsettings set "$mutter" dynamic-workspaces false
gsettings set "$mutter" workspaces-only-on-primary true
gsettings set "$mutter" overlay-key 'Super'
gsettings set "$mutter" auto-maximize true
gsettings set "$mutter" center-new-windows true
gsettings set "$mutter" attach-modal-dialogs true
gsettings set "$mutter" check-alive-timeout 5000
gsettings set "$mutter" draggable-border-width 10
gsettings set "$mutter" focus-change-on-pointer-rest true
gsettings set "$mutter" locate-pointer-key 'Control_R'
gsettings set "$mutter" output-luminance "[]"
gsettings set "$mutter" experimental-features "[]"


wm_prefs="org.gnome.desktop.wm.preferences"
gsettings set "$wm_prefs" num-workspaces 13
gsettings set "$wm_prefs" workspace-names "[]"

gsettings set "$wm_prefs" action-double-click-titlebar 'toggle-maximize'
gsettings set "$wm_prefs" action-middle-click-titlebar 'none'
gsettings set "$wm_prefs" action-right-click-titlebar 'menu'
gsettings set "$wm_prefs" resize-with-right-button false
gsettings set "$wm_prefs" button-layout 'appmenu:minimize,maximize,close'

gsettings set "$wm_prefs" auto-raise false
gsettings set "$wm_prefs" auto-raise-delay 500

gsettings set "$wm_prefs" audible-bell true
gsettings set "$wm_prefs" visual-bell false
gsettings set "$wm_prefs" visual-bell-type 'fullscreen-flash'

gsettings set "$wm_prefs" focus-mode 'click'
gsettings set "$wm_prefs" focus-new-windows 'smart'
gsettings set "$wm_prefs" mouse-button-modifier '<Super>'
gsettings set "$wm_prefs" raise-on-click true
gsettings set "$wm_prefs" disable-workarounds false

gsettings set "$wm_prefs" theme 'Adwaita' # deprecated
gsettings set "$wm_prefs" titlebar-font 'Adwaita Sans Bold 11'
gsettings set "$wm_prefs" titlebar-uses-system-font true



# Keybindings

mutter_wlnd_keys="org.gnome.mutter.wayland.keybindings"
gsettings set "$mutter_wlnd_keys" restore-shortcuts "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-1 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-2 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-3 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-4 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-5 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-6 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-7 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-8 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-9 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-10 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-11 "[]"
gsettings set "$mutter_wlnd_keys" switch-to-session-12 "[]"


mutter_keys="org.gnome.mutter.keybindings"
gsettings set "$mutter_keys" cancel-input-capture "[]"
gsettings set "$mutter_keys" rotate-monitor "[]"
gsettings set "$mutter_keys" switch-monitor "[]"
gsettings set "$mutter_keys" toggle-tiled-left "[]"
gsettings set "$mutter_keys" toggle-tiled-right "[]"


shell_keys="org.gnome.shell.keybindings"
gsettings set "$shell_keys" screenshot "[]"
gsettings set "$shell_keys" screenshot-window "['<Alt>Print']"
gsettings set "$shell_keys" show-screenshot-ui "[]"
gsettings set "$shell_keys" show-screen-recording-ui "[]"

gsettings set "$shell_keys" toggle-application-view "['<Super>a']"
gsettings set "$shell_keys" toggle-message-tray "[]"
gsettings set "$shell_keys" toggle-quick-settings "[]"
gsettings set "$shell_keys" toggle-overview "[]"

gsettings set "$shell_keys" focus-active-notification "[]"

gsettings set "$shell_keys" shift-overview-down "[]"
gsettings set "$shell_keys" shift-overview-up "[]"

gsettings set "$shell_keys" open-new-window-application-1 "[]"
gsettings set "$shell_keys" open-new-window-application-2 "[]"
gsettings set "$shell_keys" open-new-window-application-3 "[]"
gsettings set "$shell_keys" open-new-window-application-4 "[]"
gsettings set "$shell_keys" open-new-window-application-5 "[]"
gsettings set "$shell_keys" open-new-window-application-6 "[]"
gsettings set "$shell_keys" open-new-window-application-7 "[]"
gsettings set "$shell_keys" open-new-window-application-8 "[]"
gsettings set "$shell_keys" open-new-window-application-9 "[]"

gsettings set "$shell_keys" switch-to-application-1 "[]"
gsettings set "$shell_keys" switch-to-application-2 "[]"
gsettings set "$shell_keys" switch-to-application-3 "[]"
gsettings set "$shell_keys" switch-to-application-4 "[]"
gsettings set "$shell_keys" switch-to-application-5 "[]"
gsettings set "$shell_keys" switch-to-application-6 "[]"
gsettings set "$shell_keys" switch-to-application-7 "[]"
gsettings set "$shell_keys" switch-to-application-8 "[]"
gsettings set "$shell_keys" switch-to-application-9 "[]"


wm_keys="org.gnome.desktop.wm.keybindings"
gsettings set "$wm_keys" switch-input-source "['<Alt>Shift_L']"
gsettings set "$wm_keys" switch-input-source-backward "[]"

gsettings set "$wm_keys" panel-run-dialog "['<Alt>F2']"

gsettings set "$wm_keys" close "['<Alt>F4', '<Super>w']"
gsettings set "$wm_keys" activate-window-menu "[]"
gsettings set "$wm_keys" toggle-maximized "[]"
gsettings set "$wm_keys" always-on-top "[]"
gsettings set "$wm_keys" toggle-on-all-workspaces "[]"
gsettings set "$wm_keys" toggle-above "[]"
gsettings set "$wm_keys" toggle-fullscreen "['<Alt>q']"

gsettings set "$wm_keys" switch-to-workspace-left "['<Alt>e']"
gsettings set "$wm_keys" switch-to-workspace-right "['<Alt>f']"
gsettings set "$wm_keys" switch-to-workspace-down "[]"
gsettings set "$wm_keys" switch-to-workspace-up "[]"
gsettings set "$wm_keys" switch-to-workspace-1 "['<Alt>1']"
gsettings set "$wm_keys" switch-to-workspace-2 "['<Alt>2']"
gsettings set "$wm_keys" switch-to-workspace-3 "['<Alt>3']"
gsettings set "$wm_keys" switch-to-workspace-4 "['<Alt>4']"
gsettings set "$wm_keys" switch-to-workspace-5 "['<Alt>z']"
gsettings set "$wm_keys" switch-to-workspace-6 "['<Alt>x']"
gsettings set "$wm_keys" switch-to-workspace-7 "['<Alt>c']"
gsettings set "$wm_keys" switch-to-workspace-8 "['<Alt>v']"
gsettings set "$wm_keys" switch-to-workspace-9 "['<Alt>a']"
gsettings set "$wm_keys" switch-to-workspace-10 "[]"
gsettings set "$wm_keys" switch-to-workspace-11 "[]"
gsettings set "$wm_keys" switch-to-workspace-12 "[]"
gsettings set "$wm_keys" switch-to-workspace-last "['<Alt>d']"

gsettings set "$wm_keys" move-to-workspace-right "['<Control><Alt>f']"
gsettings set "$wm_keys" move-to-workspace-left "['<Control><Alt>e']"
gsettings set "$wm_keys" move-to-workspace-down "[]"
gsettings set "$wm_keys" move-to-workspace-up "[]"
gsettings set "$wm_keys" move-to-workspace-1 "['<Control><Alt>1']"
gsettings set "$wm_keys" move-to-workspace-2 "['<Control><Alt>2']"
gsettings set "$wm_keys" move-to-workspace-3 "['<Control><Alt>3']"
gsettings set "$wm_keys" move-to-workspace-4 "['<Control><Alt>4']"
gsettings set "$wm_keys" move-to-workspace-5 "['<Control><Alt>z']"
gsettings set "$wm_keys" move-to-workspace-6 "['<Control><Alt>x']"
gsettings set "$wm_keys" move-to-workspace-7 "['<Control><Alt>c']"
gsettings set "$wm_keys" move-to-workspace-8 "['<Control><Alt>v']"
gsettings set "$wm_keys" move-to-workspace-9 "['<Control><Alt>a']"
gsettings set "$wm_keys" move-to-workspace-10 "[]"
gsettings set "$wm_keys" move-to-workspace-11 "[]"
gsettings set "$wm_keys" move-to-workspace-12 "[]"
gsettings set "$wm_keys" move-to-workspace-last "[]"

gsettings set "$wm_keys" switch-applications "['<Alt>Tab']"
gsettings set "$wm_keys" switch-applications-backward "[]"
gsettings set "$wm_keys" switch-group "[]"
gsettings set "$wm_keys" switch-group-backward "[]"
gsettings set "$wm_keys" switch-panels "[]"
gsettings set "$wm_keys" switch-panels-backward "[]"
gsettings set "$wm_keys" switch-windows "[]"
gsettings set "$wm_keys" switch-windows-backward "[]"

gsettings set "$wm_keys" lower "[]"
gsettings set "$wm_keys" raise "[]"
gsettings set "$wm_keys" raise-or-lower "[]"

gsettings set "$wm_keys" begin-move "[]"
gsettings set "$wm_keys" move-to-center "[]"
gsettings set "$wm_keys" move-to-corner-ne "[]"
gsettings set "$wm_keys" move-to-corner-nw "[]"
gsettings set "$wm_keys" move-to-corner-se "[]"
gsettings set "$wm_keys" move-to-corner-sw "[]"
gsettings set "$wm_keys" move-to-monitor-down "[]"
gsettings set "$wm_keys" move-to-monitor-left "[]"
gsettings set "$wm_keys" move-to-monitor-right "[]"
gsettings set "$wm_keys" move-to-monitor-up "[]"
gsettings set "$wm_keys" move-to-side-e "[]"
gsettings set "$wm_keys" move-to-side-n "[]"
gsettings set "$wm_keys" move-to-side-s "[]"
gsettings set "$wm_keys" move-to-side-w "[]"

gsettings set "$wm_keys" begin-resize "[]"
gsettings set "$wm_keys" minimize "[]"
gsettings set "$wm_keys" maximize "[]"
gsettings set "$wm_keys" maximize-horizontally "[]"
gsettings set "$wm_keys" maximize-vertically "[]"
gsettings set "$wm_keys" unmaximize "[]"

gsettings set "$wm_keys" cycle-group "[]"
gsettings set "$wm_keys" cycle-group-backward "[]"
gsettings set "$wm_keys" cycle-panels "[]"
gsettings set "$wm_keys" cycle-panels-backward "[]"
gsettings set "$wm_keys" cycle-windows "[]"
gsettings set "$wm_keys" cycle-windows-backward "[]"

gsettings set "$wm_keys" show-desktop "[]"
gsettings set "$wm_keys" set-spew-mark "[]"
gsettings set "$wm_keys" panel-main-menu "['']"


sd_plugins="org.gnome.settings-daemon.plugins"
gsettings set "$sd_plugins.media-keys" calculator "['']"
gsettings set "$sd_plugins.media-keys" control-center "['']"
gsettings set "$sd_plugins.media-keys" home "[]"
gsettings set "$sd_plugins.media-keys" www "[]"
gsettings set "$sd_plugins.media-keys" help "[]"
gsettings set "$sd_plugins.media-keys" email "[]"
gsettings set "$sd_plugins.media-keys" media "[]"
gsettings set "$sd_plugins.media-keys" search "[]"
gsettings set "$sd_plugins.media-keys" on-screen-keyboard "[]"
gsettings set "$sd_plugins.media-keys" screenreader "[]"

gsettings set "$sd_plugins.media-keys" volume-step 4
gsettings set "$sd_plugins.media-keys" play "[]"
gsettings set "$sd_plugins.media-keys" pause "[]"
gsettings set "$sd_plugins.media-keys" previous "[]"
gsettings set "$sd_plugins.media-keys" next "[]"
gsettings set "$sd_plugins.media-keys" stop "[]"
gsettings set "$sd_plugins.media-keys" playback-forward "[]"
gsettings set "$sd_plugins.media-keys" playback-random "[]"
gsettings set "$sd_plugins.media-keys" playback-repeat "[]"
gsettings set "$sd_plugins.media-keys" playback-rewind "[]"
gsettings set "$sd_plugins.media-keys" mic-mute "[]"
gsettings set "$sd_plugins.media-keys" volume-down "[]"
gsettings set "$sd_plugins.media-keys" volume-down-precise "[]"
gsettings set "$sd_plugins.media-keys" volume-down-quiet "[]"
gsettings set "$sd_plugins.media-keys" volume-mute "[]"
gsettings set "$sd_plugins.media-keys" volume-up "[]"
gsettings set "$sd_plugins.media-keys" volume-up-precise "[]"
gsettings set "$sd_plugins.media-keys" volume-up-quiet "[]"

gsettings set "$sd_plugins.media-keys" screensaver "['<Control><Super><Alt>1']"
gsettings set "$sd_plugins.media-keys" logout "['<Control><Super><Alt>2']"
gsettings set "$sd_plugins.media-keys" suspend "['<Control><Super><Alt>3']"
gsettings set "$sd_plugins.media-keys" shutdown "['<Control><Super><Alt>4']"
gsettings set "$sd_plugins.media-keys" reboot "['<Control><Super><Alt>5']"
gsettings set "$sd_plugins.media-keys" hibernate "[]"

gsettings set "$sd_plugins.media-keys" power "[]"
gsettings set "$sd_plugins.media-keys" eject "[]"
gsettings set "$sd_plugins.media-keys" battery-status "[]"
gsettings set "$sd_plugins.media-keys" decrease-text-size "[]"
gsettings set "$sd_plugins.media-keys" increase-text-size "[]"
gsettings set "$sd_plugins.media-keys" keyboard-brightness-down "[]"
gsettings set "$sd_plugins.media-keys" keyboard-brightness-toggle "[]"
gsettings set "$sd_plugins.media-keys" keyboard-brightness-up "[]"
gsettings set "$sd_plugins.media-keys" magnifier "[]"
gsettings set "$sd_plugins.media-keys" magnifier-zoom-in "[]"
gsettings set "$sd_plugins.media-keys" magnifier-zoom-out "[]"

gsettings set "$sd_plugins.media-keys" screen-brightness-cycle "[]"
gsettings set "$sd_plugins.media-keys" screen-brightness-down "[]"
gsettings set "$sd_plugins.media-keys" screen-brightness-up "[]"
gsettings set "$sd_plugins.media-keys" toggle-contrast "[]"

gsettings set "$sd_plugins.media-keys" rfkill "[]"
gsettings set "$sd_plugins.media-keys" rfkill-bluetooth "[]"

gsettings set "$sd_plugins.media-keys" touchpad-off "[]"
gsettings set "$sd_plugins.media-keys" touchpad-on "[]"
gsettings set "$sd_plugins.media-keys" touchpad-toggle "[]"

gsettings set "$sd_plugins.media-keys" rotate-video-lock "[]"
gsettings set "$sd_plugins.media-keys" rotate-video-lock-static "[]"



# Power

gsettings set "$sd_plugins.color" night-light-enabled false
gsettings set "$sd_plugins.power" ambient-enabled true
gsettings set "$sd_plugins.power" idle-brightness 30
gsettings set "$sd_plugins.power" idle-dim true
gsettings set "$sd_plugins.power" power-button-action 'suspend'
gsettings set "$sd_plugins.power" power-saver-profile-on-low-battery true
gsettings set "$sd_plugins.power" sleep-inactive-ac-timeout 7200
gsettings set "$sd_plugins.power" sleep-inactive-ac-type 'suspend'
gsettings set "$sd_plugins.power" sleep-inactive-battery-timeout 900
gsettings set "$sd_plugins.power" sleep-inactive-battery-type 'nothing'



# Peripherals

gnome_peripherals="org.gnome.desktop.peripherals"
gsettings set "$gnome_peripherals.keyboard" numlock-state true
gsettings set "$gnome_peripherals.keyboard" remember-numlock-state true
gsettings set "$gnome_peripherals.mouse" speed -0.6
gsettings set "$gnome_peripherals.mouse" natural-scroll false
gsettings set "$gnome_peripherals.mouse" middle-click-emulation false
gsettings set "$gnome_peripherals.touchpad" middle-click-emulation false
gsettings set "$gnome_peripherals.touchpad" natural-scroll true
gsettings set "$gnome_peripherals.touchpad" disable-while-typing true
gsettings set "$gnome_peripherals.touchpad" tap-and-drag true
gsettings set "$gnome_peripherals.touchpad" tap-and-drag-lock false
gsettings set "$gnome_peripherals.touchpad" tap-to-click true
gsettings set "$gnome_peripherals.touchpad" two-finger-scrolling-enabled true


sd_peripherals="org.gnome.settings-daemon.peripherals"
gsettings set "$sd_peripherals.keyboard" bell-custom-file ''
gsettings set "$sd_peripherals.keyboard" bell-duration 100
gsettings set "$sd_peripherals.keyboard" bell-mode 'on'
gsettings set "$sd_peripherals.keyboard" bell-pitch 400
gsettings set "$sd_peripherals.keyboard" click true
gsettings set "$sd_peripherals.keyboard" click-volume 0
gsettings set "$sd_peripherals.smartcard" removal-action 'none'
gsettings set "$sd_peripherals.touchscreen" orientation-lock false



# GNOME Desktop

gnome_desktop="org.gnome.desktop"
gsettings set "$gnome_desktop.input-sources" sources "[('xkb', 'us'), ('xkb', 'ru')]"
gsettings set "$gnome_desktop.input-sources" per-window false

gsettings set "$gnome_desktop.screensaver" lock-enabled true
gsettings set "$gnome_desktop.screensaver" primary-color '#02023c3c8888'
gsettings set "$gnome_desktop.screensaver" secondary-color '#5789ca'

gsettings set "$gnome_desktop.background" picture-opacity 100
gsettings set "$gnome_desktop.background" picture-options 'centered'

gsettings set "$gnome_desktop.privacy" remove-old-temp-files true
gsettings set "$gnome_desktop.privacy" remove-old-trash-files false
gsettings set "$gnome_desktop.privacy" old-files-age 7

gsettings set "$gnome_desktop.sound" allow-volume-above-100-percent false

gsettings set "$gnome_desktop.interface" cursor-theme "Adwaita"
gsettings set "$gnome_desktop.interface" gtk-theme "adw-gtk3"
gsettings set "$gnome_desktop.interface" gtk-enable-primary-paste false
gsettings set "$gnome_desktop.interface" enable-hot-corners false
gsettings set "$gnome_desktop.interface" enable-animations false
gsettings set "$gnome_desktop.interface" clock-format '24h'
gsettings set "$gnome_desktop.interface" cursor-blink false
gsettings set "$gnome_desktop.interface" color-scheme 'prefer-dark'
gsettings set "$gnome_desktop.interface" locate-pointer true

gsettings set "$gnome_desktop.notifications" show-in-lock-screen false

gsettings set "$gnome_desktop.session" idle-delay 0



# GNOME Manjaro Pre-installed Extensions

gnome_extensions="org.gnome.shell.extensions"
gsettings set "$gnome_extensions.apps-menu" apps-menu-toggle-menu "[]"
gsettings set "$gnome_extensions.system-monitor" show-cpu true
gsettings set "$gnome_extensions.system-monitor" show-download true
gsettings set "$gnome_extensions.system-monitor" show-memory true
gsettings set "$gnome_extensions.system-monitor" show-swap true
gsettings set "$gnome_extensions.system-monitor" show-upload true



# Nautilus

nautilus="org.gnome.nautilus"
gsettings set "$nautilus.list-view" default-zoom-level 'small'
gsettings set "$nautilus.list-view" use-tree-view true
gsettings set "$nautilus.preferences" default-folder-viewer 'list-view'
gsettings set "$nautilus.preferences" show-hidden-files true



# Etc

gsettings set org.gtk.Settings.FileChooser show-hidden true
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden true
gsettings set org.gtk.Settings.FileChooser clock-format "24h"
gsettings set org.gtk.gtk4.Settings.FileChooser clock-format "24h"


gsettings set org.gnome.settings-daemon.global-shortcuts applications "[]"
