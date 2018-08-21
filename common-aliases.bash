alias ws="cd ~/workspace"

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
alias gfb="git fb" # `git fb' is aliased to `!zsh -c "git branch | grep $1 | xargs -n 1 git checkout"'

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

alias ls='ls -lG'

# See .zshrc for this function
alias bo='branchopen'

# Rails
alias berc='bundle exec rails c'
alias bi='bundle install'
alias brspec='bin/rspec'

# Opendoor stuff
alias startweb='bin/rails server -p ${PORT:-5000} -b 0.0.0.0'
alias startinst='cd institutions; WEB_ENVIRONMENT=development python wsgi.py'
alias instsh='FLASK_APP=autoapp.py flask shell'
alias prodwebsh='cd $WEB_PATH; ./bin/development/console production'
alias prodwebrestart='cd $WEB_PATH; heroku restart -a opendoor-web'
#alias prodwebsh='cd $WEB_PATH; heroku run -a opendoor-web OD_CURRENT_USER_EMAIL="gordon@opendoor.com" bin/rails console'
alias prodhelloritosh='heroku run -a hellorito rails c'
alias actinst='source activate institutions'
#alias startconsumer='CONSUMER_CONFIG=true foreman start webpack'
alias startconsumer='cd /Users/gordonkoo/workspace/opendoor/web/packages/consumer; yarn start'

alias scr='screen'
alias ag='ag --path-to-ignore ~/.ignore'
alias gpbo='gp && bo'
alias changedfiles='git diff --find-renames --find-copies --diff-filter=d --cached --name-only'
