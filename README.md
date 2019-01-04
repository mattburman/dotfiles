# My config files

This repo contains config for various things for a macOS setup.

# .gitignore is a whitelist

I generally use .config for all config files, including those I don't want to check in.
Therefore the `.gitignore` is a whitelist rather than a blacklist

# dotbot

Dotbot is makes it easier to install dotfiles
by taking a `install.conf.yaml` of symlinks and creating them,
and running shell commands

Those managed by dotbot are prefixed with a dot below:

# Configured
## . karabiner.edn

This file configures `yqrashawn/GokuRakuJoudo`
which configures `tekezo/Karabiner-Elements` in a nice `.edn` format

## Brewfile

This is a list of system utils and apps that I use to be installed on any fresh builds
I have an appetite to move to Nix but this is what I have for now

## LaunchDaemons
This directory contains LaunchDaemons with it's own README on how to configure

