function updateall() {
  echo "⚡ Updating Nix packages: "
  darwin-rebuild switch
  echo "⚡ Updating tldr definitions: "
  tldr --update
  echo "⚡ Updating brew packages: "
  brew update
  brew upgrade
  echo "⚡ Updating cask apps: "
  brew cask outdated
  brew cask upgrade
  echo "⚡ Updating mas apps: "
  mas upgrade
}

