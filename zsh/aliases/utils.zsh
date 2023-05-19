alias cgrep="grep --color=always"
alias mk="make"
alias dogall="dog A NS MX TXT CNAME SOA"

function bak () {
  mv $1{,.bak}
}

function unbak () {
  mv "$(echo $1 | sed 's/.bak//g')"{.bak,}
}

alias v="nvim"

alias tm="tmux"

alias jqc="jq -c"

alias jq-num-sum="jq -s '{sum:add,min:min,max:max,avg:(add/length),med:(sort|if length%2==1 then.[length/2|floor]else[.[length/2-1,length/2]]|add/2 end),num:length}'"

alias jq-to-csv="jq -r '[.[]] | @csv'"

function piped-or-arg1 {
  [[ -p /dev/stdin ]] && cat - || echo "$1"
}

# does alias expansion https://blog.mact.me/2012/09/06/using-watch-with-a-bash-alias
alias watch="watch -n 1 "

alias ls="ls --color=auto"
alias lsa="ls -a"
alias la="ls -a"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"


function smrz() {
  f=$1
  wc "$f"
  echo
  head "$f"
}


function diffsort() {
  diff <("$@") <("$@" | sort)
}

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

alias archivebox="docker run -v "$HOME"/c/data/archivebox:/data -it archivebox/archivebox"
alias archivebox-server="docker run -v "$HOME"/c/data/archivebox:/data -p 8000:8000 -it archivebox/archivebox server 0.0.0.0:8000"

alias grep-urls='grep -Eo "(http|https|ws|wss)://[a-zA-Z0-9./?=_:-]*(#\S*)?"'
alias grep-ips="grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"

alias sed-host="sed -e 's/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/'"

alias ia-save-cb='ia-save "$(pbpaste)"'
