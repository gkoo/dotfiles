# Path to your oh-my-zsh configuration.
export ZSH="/Users/gkoo/.oh-my-zsh"

plugins=(git)

# Set name of the theme to load.
# Look in $ZDOTDIR/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="fino-time-gkoo"
# ZSH_THEME="fino-time"
# ZSH_THEME="muse"
# ZSH_THEME="flazz"
DEFAULT_USER="gkoo"

source $ZSH/oh-my-zsh.sh

# User configuration

#export PATH=$HOME/bin:/usr/local/Cellar/git/1.9.2/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

#export PATH=/Users/gkoo/miniconda3/bin:$PATH

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
cdpath=( ~/workspace/notion/ ~/workspace/ ~/ )

# Rbenv
#eval "$(rbenv init -)"

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
#source <(kubectl completion zsh)

# gets the current branch name
gitbranch() {
  git branch | egrep "^\*" | cut -d ' ' -f 2
}

gitrepo() {
	# For ssh remotes
  # git remote -v | egrep "^origin.+\(push\)$" | cut -f 2 | cut -d " " -f 1 | cut -d ":" -f 2 | cut -d "." -f 1
	# For https remotes
	git remote -v | egrep "^origin.+\(push\)$" | cut -f 2 | cut -d " " -f 1 | cut -d "/" -f 4,5 | cut -d "." -f 1
}

gitlastsha() {
  g log -n 1 --oneline | cut -d ' ' -f 1
}

# opens a link to the git branch in GHE
branchopen() {
  open "http://www.github.com/$(gitrepo)/compare/$(gitbranch)"
}

terraform-resources() {
   awk '/^module/ { gsub("\"", "", $2 ); gsub("\"", "", $1 ); printf "--target %s.%s ", $1, $2 } ; /^(resource)/ { gsub("\"", "", $3 ); gsub("\"", "", $2 ); printf  "--target %s.%s ", $2,  $3  } ; END { print ""}' "$@"
}

source $HOME/.dotfiles/secrets

#eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(rbenv init -)"
eval "$(notion completion --install)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export NOTION_NEXT="$HOME/workspace/notion/notion-next"
export NOTION_NO_PREPUSH=true
export NOTION_DEVELOPER_EMAIL=gordon@makenotion.com
