# My config files

This repo contains config for various things for a macOS setup.

# dotbot

Dotbot makes it easier to install dotfiles
by taking a `install.conf.yaml` of symlinks and creating them,
and running shell commands

# Configured

## (.) karabiner.edn

This file configures `yqrashawn/GokuRakuJoudo`
which configures `tekezo/Karabiner-Elements` in a nice `.edn` format
You need to make sure karabiner-elements has a profile named `Goku` and that it is selected.

## Brewfile

This is a list of cask apps that I use to be installed on any fresh builds.
There are also some cli tools that are not on nix yet.
Install via `brew bundle`

## Nix

Nix is another package manager. Brew will be installed alongside, with Nix packages taking precedence since it is first in \$PATH. In general I will try to install most CLI utils via Nix and any desktop apps via Brew cask.

## LaunchDaemons

This directory contains LaunchDaemons with it's own README on how to configure
