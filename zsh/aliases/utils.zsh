alias cgrep="grep --color=always"
alias mk="make"
alias dogall="dog A NS MX TXT CNAME SOA"

alias v="nvim"

alias tm="tmux"

# does alias expansion https://blog.mact.me/2012/09/06/using-watch-with-a-bash-alias
alias watch="watch -n 1 "

alias ls="ls --color=auto"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

alias ungron="gron -u"

alias gocheck="golangci-lint run --no-config --deadline=30m \
  --disable-all --enable=deadcode  --enable=gocyclo --enable=golint --enable=varcheck \
  --enable=structcheck --enable=maligned --enable=errcheck --enable=dupl --enable=ineffassign \
  --enable=interfacer --enable=unconvert --enable=goconst --enable=gosec --enable=megacheck \
  --enable=scopelint \
  --enable=gofmt --concurrency=16"

alias vim="nvim"

alias tolower="tr '[:upper:]' '[:lower:]'"
alias toupper="tr '[:lower:]' '[:upper:]'"
alias hyphenate="tr ' ' '-'"
alias tofilename='tolower | hyphenate'

function ia-save() {
  curl -s -I "https://web.archive.org/save/$1" | \
  egrep '^location:' | \
  awk '{ print $2 }';
}
