alias ws="cd ~/workspace"

# Git
alias gcob="git checkout -b"
alias gft="git fetch"
# Commented out next line because it was causing error messages when opening a new shell
# alias gpfo="git push -f origin $(git rev-parse --abbrev-ref HEAD)"
#alias gclone="git clone"
alias gfb="git fb" # `git fb' is aliased to `!zsh -c "git branch | grep $1 | xargs -n 1 git checkout"'

# Terraform
alias tf="terraform"
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"

# Zsh
alias zshreload="source \$HOME/.zshrc"

alias mvimdiff="mvim -d"
alias agr="ag --ruby"
alias ag='ag --path-to-ignore ~/.ignore'

# Hub
#alias g="hub"
#alias gpr="hub pull-request"

alias vboxrestart="sudo /Library/StartupItems/VirtualBox/VirtualBox restart"

alias ls='ls -lG'

# See .zshrc for this function
alias bo='branchopen'

alias scr='screen'
alias ag='ag --path-to-ignore ~/.ignore'
alias gpbo='gp && bo'
alias changedfiles='git diff --find-renames --find-copies --diff-filter=d --cached --name-only'
alias prettyprintjson='pbpaste | jq > ~/tmp/prettyprint.json && open ~/tmp/prettyprint.json'
alias gprunebranches='git checkout main && comm -12 <(git branch | sed "s/ *//g") <(git remote prune --dry-run origin | sed "s/^.*origin\///g") | xargs -L1 -J % git branch -D %'
alias gotest="go test ./..."
alias startkfc="cd ~/workspace/koofitnessclub/; foreman start -f Procfile.dev -p 3000"
alias goserver="go run cmd/server/*.go"

# Notion
alias nn='cd ~/workspace/notion/notion-next'
alias awslogin='aws sso login --profile infrastructure-admin'
alias ntn=notion
alias ntest="notion test"
alias jest="$NOTION_NEXT/node_modules/.bin/jest"
alias ntncircleci="notion circleci codegen-config"
