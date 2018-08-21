# Path to your oh-my-zsh configuration.
ZSH=$ZDOTDIR/.oh-my-zsh

# Set name of the theme to load.
# Look in $ZDOTDIR/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="fino"
ZSH_THEME="muse"
DEFAULT_USER="gordonkoo"

# User configuration

#export PATH=$HOME/bin:/usr/local/Cellar/git/1.9.2/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

#export PATH=/Users/gordonkoo/miniconda3/bin:$PATH

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

# ===============
# Gordon's stuff!
# ===============

# Sets a search path for the cd command
cdpath=( ~/workspace/opendoor/ ~/workspace/ ~/ )

# Rbenv
eval "$(rbenv init -)"

# vi mode
# `man zshzle` for more info
bindkey -v
# get into command mode without leaving home row
bindkey -M viins 'jk' vi-cmd-mode
# backwards search
bindkey -M vicmd '?' history-incremental-search-backward

# When directory is changed set xterm title to host:dir
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]l%~\e\\";;
        *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%m:%~\a";;
    esac
}

source ~/.dotfiles/common-aliases.bash

# K8s
source <(kubectl completion zsh)

# gets the current branch name
gitbranch() {
  git branch | egrep "^\*" | cut -d ' ' -f 2
}

gitrepo() {
  git remote -v | egrep "^origin.+\(push\)$" | cut -f 2 | cut -d " " -f 1 | cut -d ":" -f 2 | cut -d "." -f 1
}

gitlastsha() {
  g log -n 1 --oneline | cut -d ' ' -f 1
}

gprunebranches() {
  git checkout master && comm -12 <(git branch | sed "s/ *//g") <(git remote prune origin | sed "s/^.*origin\///g") | xargs -L1 -J % git branch -D %
}

instpods() {
  cd institutions/; kubectl --namespace=$1 get pods | grep institutions
}

sshinstpod() {
  kubectl --namespace=$1 exec -it $2 bash
}

# opens a link to the git branch in GHE
branchopen() {
  open "http://www.github.com/$(gitrepo)/compare/$(gitbranch)"
}

reviewappsh() {
  heroku run -a $1 rails c
}

export OD_CURRENT_USER_EMAIL="gordon@opendoor.com"
export WEB_PATH="/Users/gordonkoo/workspace/opendoor/web/"
export ANDROID_HOME=/Users/gordonkoo/Library/Android/sdk
