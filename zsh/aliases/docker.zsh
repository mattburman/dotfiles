# extending https://github.com/akarzim/zsh-docker-aliases

# remove all containers
alias dkCnuke="docker rm -v $(docker ps -aq)"

# restart
alias dkcrs="docker-compose restart"

# up daemonised
alias dkcud="docker-compose up -d"

# logs
alias dkclf="docker-compose logs -f"
alias dkclt="docker-compose logs -t"
alias dkclft="docker-compose logs -f -t"
alias dkcltf="docker-compose logs -f -t"

alias ctop='docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest'
