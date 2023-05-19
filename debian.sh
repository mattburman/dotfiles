sudo apt -y install
sudo apt -y upgrade
sudo apt -y install $(awk '{print $1}' utils.txt)
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
# chsh -s /bin/zsh
