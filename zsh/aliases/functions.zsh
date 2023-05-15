function updateall() {
  echo "⚡ Updating Nix packages: "
  darwin-rebuild switch
  echo "⚡ Updating tldr definitions: "
  tldr --update
  echo "⚡ Updating brew packages: "
  brew update
  brew upgrade
  echo "⚡ Updating cask apps: "
  brew outdated --cask
  brew upgrade --cask
  echo "⚡ Updating mas apps: "
  mas upgrade
}

# save url at arg to internet archive
function ia-save() {
  curl -s -I "https://web.archive.org/save/$1" | \
  egrep '^location:' | \
  awk '{ print $2 }';
}
