# https://techcommons.stanford.edu/topics/git/show-git-branch-bash-prompt

# Source this file in your .bashrc / .bash_prompt
# Git branch in prompt stuff...
function parse_git_branch {

  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'

}

function proml {

  local     DEFAULT="\[\033[0m\]"

  case $TERM in

    xterm*)

    TITLEBAR='\[\033]0;\u@\h:\w\007\]'

    ;;

    *)

    TITLEBAR=""

    ;;

  esac

PS1="${TITLEBAR}\u:\w$WHITE\$(parse_git_branch) $LIGHT_GRAY> "

PS2='> '

PS4='+ '

}

proml

