# Note: before adding check there is not an equivalent here:
# https://github.com/ahmetb/kubectl-aliases/blob/master/.kubectl_aliases

alias kcr='kubectl create'

alias kco='kubectl config'
alias kcogc='kubectl config get-contexts'
alias kcocc='kubectl config current-context'
alias kcouc='kubectl config use-context'


alias k='kubectl'

alias kg='k get'
alias kd='k describe'
alias krm='k delete'
alias ka='k apply'
alias kr='k run'
alias kcr='k create'
alias kco='k config'
alias ked='k edit'

alias kgpo='kg po'
alias kgrs='kg rs'
alias kgdep='kg deploy'
alias kgsvc='kg svc'
alias kgns='kg ns'
alias kgcm='kg configmap'

alias kcrdry='kcr --dry-run=client -o yaml'
alias krundry='krun --dry-run=client -o yaml' # for creating pods. bare in mind the label is run rather than app

export dry='--dry-run=client -o yaml'

# edit current context to set the namespace e.g. kn kube-system
alias kn="kubectl config set-context --current --namespace"
