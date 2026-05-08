#!/bin/bash

# Use kreadconfig6 and kwriteconfig6 to get and set config values.
#
# To figure out what config changes to make:
#   1. cd ~/.config && git init && git add . && git commit -m "baseline"
#   2. Make config changes in GUI.
#   3. git diff
#   4. rm -rf ~/.config/.git

if ! [ "${EUID:-$(id -u)}" -eq 0 ]; then
	echo "ERROR: do not run this script as root"
	exit 1
fi

ssh-keygen -q -t ed25519 -N '' -f ~/.ssh/id_ed25519

# Set vim as default editor
sudo update-alternatives --set editor /usr/bin/vim.basic

# Disable sudo password feedback:
echo "Defaults !pwfeedback" | sudo EDITOR=tee visudo -f /etc/sudoers.d/01-disable-pwfeedback

# Set KDE Global Color Scheme
# kwriteconfig6 --file kdeglobals --group General --key ColorScheme "BreezeDark"

# Manually set GTK 3 theme (using standard sed, as it's not a KDE-managed config)
# mkdir -p ~/.config/gtk-3.0
# touch ~/.config/gtk-3.0/settings.ini
# sed -i 's/^gtk-theme-name=.*/gtk-theme-name=Breeze-Dark/' ~/.config/gtk-3.0/settings.ini || echo "gtk-theme-name=Breeze-Dark" >> ~/.config/gtk-3.0/settings.ini

# Decrease key repeat delay
# System Settings -> Keyboard -> Key Repeat -> Delay 200 ms, Repeat 25 /s
kwriteconfig6 --file kcminputrc --group Keyboard --key RepeatDelay 200
kwriteconfig6 --file kcminputrc --group Keyboard --key RepeatRate 25

# Make sure new windows take focus
# Focus stealing prevention -> None (0 = None, 1 = Low, 2 = Normal, 3 = High, 4 = Extreme)
# System Settings -> Window Behavior -> Focus stealing prevention -> None
kwriteconfig6 --file kwinrc --group Windows --key FocusStealingPreventionLevel 0

# Raise window on left click
# System Settings -> Window Behavior -> Window Actions -> Inner Window, Titlebar and Frame Actions -> Left Click: Activate, raise and move
kwriteconfig6 --file kwinrc --group MouseBindings --key CommandAll1 "Activate, raise and move"

# Disable media controls on lock screen
# System Settings -> Workspace Behavior -> Screen Locking -> Appearance -> disable everything
kwriteconfig6 --file kscreenlockerrc --group Greeter --group LnF --group General --key alwaysShowClock false
kwriteconfig6 --file kscreenlockerrc --group Greeter --group LnF --group General --key showMediaControls false
kwriteconfig6 --file kscreenlockerrc --group Greeter --group Wallpaper --group "org.kde.image" --group General --key Image "file:///usr/share/wallpapers/KubuntuBlack/"
kwriteconfig6 --file kscreenlockerrc --group Greeter --group Wallpaper --group "org.kde.image" --group General --key PreviewImage "file:///usr/share/wallpapers/KubuntuBlack/"

# Animation speed (1.0 is normal, 0.5 is faster, 0.0 is instant)
# System Settings -> Workspace Behavior -> General Behavior -> Animation speed -> faster
kwriteconfig6 --file kdeglobals --group KDE --key AnimationDurationFactor 0.17

# Alt+Tab previews:
# System Settings -> Window Management -> Task Switcher -> Visualization -> Thumbnail Grid
#kwriteconfig6 --file kwinrc --group TabBox --key LayoutName "thumbnail_grid"

# Don't remember session:
# System Settings -> Startup and Shutdown -> Desktop Session -> Start with an empty session
kwriteconfig6 --file ksmserverrc --group General --key loginMode "emptySession"

# NumLock on KDE start
# System Settings -> Input Devices -> Keyboard -> NumLock on Plasma Startup -> Turn on
# 0 = Turn On, 1 = Turn Off, 2 = Leave Unchanged
kwriteconfig6 --file kcminputrc --group Keyboard --key NumLock 0

# Maximize windows
# System Settings -> Shortcuts -> KWin -> Maximize Window -> Meta+Up
kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window Maximize" "Meta+PgUp\tMeta+Up,Meta+PgUp,Maximize Window"

# Shortcut: Terminal
kwriteconfig6 --file kglobalshortcutsrc --group services --group "net.local.tilix.desktop" --key "_launch" "Meta+T"


#Configure 3x3 workspace grid with workspace preview widget

# Disable scrolling on desktop
#right-click the desktop -> Desktop settings -> Mouse actions -> remove "vertical scrollwheel: xxx"

# Hotkeys:
# 	Terminal:              Meta+t
# 	Switch to Desktop 1-9: Meta+Num+1-9
# 	Window to Desktop 1-9: Meta+Ctrl+Num+1-9
# for i in {1..9}; do
#     # Switch to Desktop 1-9 (Meta+Num+1 to Meta+Num+9)
#     kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop $i" "Meta+Num+$i,none,Switch to Desktop $i"
#
#     # Move Window to Desktop 1-9 (Meta+Ctrl+Num+1 to Meta+Ctrl+Num+9)
#     kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop $i" "Meta+Ctrl+Num+$i,none,Window to Desktop $i"
# done

# Clipboard: Save history across desktop sessions: off
kwriteconfig6 --file klipperrc --group General --key KeepClipboardContents false

# Clipboard: History Size: 1
kwriteconfig6 --file klipperrc --group General --key MaxClipItems 1


# krunner
pluginList = (
	baloosearchEnabled
	browserhistoryEnabled
	browsertabsEnabled
	calculatorEnabled
	helprunnerEnabled
	krunner_appstreamEnabled
	krunner_bookmarksrunnerEnabled
	krunner_charrunnerEnabled
	krunner_colorsEnabled
	krunner_dictionaryEnabled
	krunner_katesessionsEnabled
	krunner_killEnabled
	krunner_konsoleprofilesEnabled
	krunner_placesrunnerEnabled
	krunner_plasma-desktopEnabled
	krunner_powerdevilEnabled
	krunner_recentdocumentsEnabled
	krunner_sessionsEnabled
	krunner_spellcheckEnabled
	krunner_systemsettingsEnabled
	locationsEnabled
	org.kde.activities2Enabled
	org.kde.datetimeEnabled
)
for thisPlugin in ${pluginList[@]}; do
	kwriteconfig6 --file krunnerrc --group Plugins --key $thisPlugin false
done

# Show previews/thumbnails when browsing remote file shares in Dolphin:
# For previews on Samba shares, you need to alter the Dolphin settings. Open
# Dolphin > (wrench in top right) > Configure Dolphin > General. Change the
# "Remote files above" setting to a level you think is necessary.


# Reload Global Shortcuts
qdbus org.kde.kglobalaccel /kglobalaccel org.kde.KGlobalAccel.applyDefaults

# Reload KWin (Window Manager)
qdbus org.kde.KWin /KWin reconfigure

# Restart Plasma Shell (Taskbar, Desktop)
systemctl restart --user plasma-plasmashell.service
