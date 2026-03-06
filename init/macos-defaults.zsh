#!/usr/bin/env zsh

function restart() {
    killall $1
}

function set_default() {
    local domain=$1
    local name=$2
    local arg_type
    local arg_value

    if [[ "${3}" =~ (-float|-int|-bool) ]]; then
        arg_type=$3
        arg_value=$4
    else
        arg_type=''
        arg_value=$3
    fi
    if ! defaults write "${domain}" ${name} ${arg_type} "${arg_value}"; then
        echo "Error, could not write ${domain}/${name}"
        exit 1
    fi
}

## ===============================================================================================

echo "─ System Settings"
echo "  └─ Disable 'Are you sure?' warning when opening apps"
set_default com.apple.LaunchServices LSQuarantine -bool false

echo "  └─ Expand save panel by default"
set_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
set_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "  └─ Expand Print Panel By Default"
set_default NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
set_default NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "  └─ Disable Mission Control Animation"
set_default com.apple.dock expose-animation-duration -int 0

echo "  └─ Disable Dialog Box Animation"
set_default NSGlobalDomain NSWindowResizeTime 0.001

echo "  └─ Require password immediately after sleep"
set_default com.apple.screensaver askForPassword -int 1
set_default com.apple.screensaver askForPasswordDelay -int 0

# Disable Notification Center:
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

iecho "Disable transparency in the menu bar and elsewhere on Yosemite"
defaults write com.apple.universalaccess reduceTransparency -bool true

Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

Disable the over-the-top focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

## ===============================================================================================

echo "─ Customize System UI Server"
echo "  └─ Change Screenshot Format (e.g., to PNG)"
set_default com.apple.screencapture type png

echo "  └─ Change Screenshot Location"
set_default com.apple.screencapture location ~/Pictures

echo "  └─ Disable shadow in screenshots"
set_default com.apple.screencapture disable-shadow -bool true

echo "  └─ Disable New Window Animation"
set_default NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool FALSE; killall SystemUIServer

restart SystemUIServer

## ===============================================================================================

echo "─ Customize Finder"
echo "  └─ Show hidden files in Finder"
set_default com.apple.finder AppleShowAllFiles -bool true

echo "  └─ Disable Quick Look Window Animation"
set_default -g QLPanelAnimationDuration -float 0

echo "  └─ Show Full Path In Finder Title Bar"
set_default com.apple.finder _FXShowPosixPathInTitle -bool true

echo "  └─ Add 'Quit' Menu Item to Finder"
set_default com.apple.finder QuitMenuItem -bool true

restart Finder

## ===============================================================================================

echo "─ Customize Dock"
echo "  └─ Speed up Dock show/hide animation"
set_default com.apple.Dock autohide-delay -float 0
set_default com.apple.dock autohide-time-modifier -int 0

echo "  └─ Resize Dock"
set_default com.apple.dock tilesize -int 38

echo "  └─ Transparent Icon For Hidden Applications"
set_default com.apple.dock showhidden -bool true

echo "  └─ Disable Bouncing Applications In Dock"
set_default com.apple.dock no-bouncing -bool true

restart Dock

## ===============================================================================================
## ===============================================================================================

Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on
