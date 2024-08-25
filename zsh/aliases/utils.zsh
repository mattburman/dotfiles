alias cgrep="grep --color=always"
alias mk="make"
alias dogall="dog A NS MX TXT CNAME SOA"

alias l='ls -l'
alias la='ls -la'
alias lh='ls -lh'
alias lah='ls -lah'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias x='exit'

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

function bak () {
  mv $1{,.bak}
}

function unbak () {
  mv "$(echo $1 | sed 's/.bak//g')"{.bak,}
}

alias wt='watch'

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
alias dircolors='gdircolors'
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:';
# export LS_COLORS="di=36;46:ln=30;46:so=32;46:pi=33;46:ex=31;46:bd=34;46:cd=34;46:su=30;46:sg=30;46:tw=30;46:ow=30;46"
# export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export ZLS_COLORS="$LS_COLORS"


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

alias grep-urls='grep -Eo "(http|https|ws|wss)://[a-zA-Z0-9./?=_:\%-]*(#\S*)?"'
alias grep-ips="grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"

alias sed-host="sed -e 's/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/'"
alias sed-strip-whitespace="sed -r 's/\s+//g'"

alias ia-save-cb='ia-save "$(pbpaste)"'
