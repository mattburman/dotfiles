# date helpers

alias ymd='date +"%Y%m%d"'
alias ymdh='date +"%Y%m%d-%H"'

alias datefromunix='cut -c1-10 | xargs -I{} date -d "@{}"'
