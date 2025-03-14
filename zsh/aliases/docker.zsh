# extending https://github.com/akarzim/zsh-docker-aliases

alias dkpsaq='docker ps -aq'

alias dkeit='docker exec -it'
alias dkeitl='dkeit $(docker ps -aqn 1) bash'

alias dkce='docker-compose exec'

dkcsh() { docker-compose exec -it "$1" /bin/sh }
dkcbash() { docker-compose exec -it "$1" /bin/bash }

# remove all containers
alias dkCnuke='docker rm -v $(docker ps -aq)'

# restart
alias dkcrs="docker-compose restart"

# up daemonised
alias dkcud="docker-compose up -d"
alias dkcud="docker-compose up -d --wait"

alias dkcdud="docker-compose down && docker-compose up -d"
alias dkcdudw="docker-compose down && docker-compose up -d --wait"

# logs
alias dkclf="docker-compose logs -f"
alias dkclt="docker-compose logs -t"
alias dkclft="docker-compose logs -f -t"
alias dkcltf="docker-compose logs -f -t"

alias ctop='docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest'

dkcn() {
  local IN=$1
  local IN=${IN:-docker-compose.yml}
  local OUT=$2
  local OUT=${OUT:-nfsvolumes.yml}
  local VOLBLOCK=$(
    cat <<-END

    driver: local
    driver_opts:
      type: nfs
      device: ':${PWD}'
      o: addr=host.docker.internal,rw,nolock,hard,nointr,nfsvers=3
END

  )
  echo 'volumes:' >$OUT
  yq '.volumes | keys[]' $IN | xargs -I'{}' echo "  {}:$VOLBLOCK" >>$OUT
}
