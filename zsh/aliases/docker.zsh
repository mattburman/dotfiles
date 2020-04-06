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

