alias got='go test'
alias gota='go test ./...'
alias gotaf="! go test ./... | grep -vE '^(ok|\?)'"

alias gof='go fmt'
alias gofa='go fmt ./...'
alias goi='goimports'

alias gor='go run'

alias goformat='goimports -w -l .;gofmt -s -w -l .;gofumpt -l -w .'
alias golint='golangci-lint run --disable nonamedreturns --disable exhaustruct --disable lll'
