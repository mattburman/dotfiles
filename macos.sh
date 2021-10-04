# fast key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# trackpad speed
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

## dock

# fast opening and closing windows and popovers
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# speed up dialog boxes
defaults write NSGlobalDomain NSWindowResizeTime 0.001

# only active app
defaults write com.apple.dock static-only -bool true

# cmd-option-d show/hide animation is instant.
defaults write com.apple.dock autohide-time-modifier -float 0

killall Dock
