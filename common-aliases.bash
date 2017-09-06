alias ws="cd ~/workspace"
alias pbws="cd ~/workspace/pebble-dev"

# Git
alias gcob="git checkout -b"
alias gplom="git pull origin master"
#alias gpsom="git push origin master"
alias grb="git rebase"
alias grbm="git rebase master"
alias gft="git fetch"
# Commented out next line because it was causing error messages when opening a new shell
# alias gpfo="git push -f origin $(git rev-parse --abbrev-ref HEAD)"
#alias gclone="git clone"
alias gstl="git stash list"

# Vagrant
alias v="vagrant"
alias vpr="vagrant provision"
alias vsh="vagrant ssh"
alias vup="vagrant up"
alias vh="vagrant halt"
alias vsus="vagrant suspend"
alias vr="vagrant resume"

# Zsh
alias zshreload="source $ZDOTDIR/.zshrc"

alias mvimdiff="mvim -d"
alias agr="ag --ruby"

# Hub
#alias g="hub"
#alias gpr="hub pull-request"

alias vboxrestart="sudo /Library/StartupItems/VirtualBox/VirtualBox restart"

# Goldkey
alias rekey='ssh-add -e /usr/lib/opensc-pkcs11.so; ssh-add -s /usr/lib/opensc-pkcs11.so -t 3600'

alias ls='ls -lG'

# See .zshrc for this function
alias bo='branchopen'

# Rails
alias berc='bundle exec rails c'
