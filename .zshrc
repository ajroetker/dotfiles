# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="eastwood"

alias ag="ag --all-types --smart-case"
alias be="bundle exec"
alias ppjson="python -m json.tool"
alias pdb="cd ~/Projects/clj/puppetdb"
alias emacs='open -a /Applications/Emacs.app $1'
alias hco="hub checkout"
alias pdb="cd ~/Projects/clj/puppetdb"
alias cleanpdb='pdb && dropdb puppetdb && createdb -E UTF8 -O puppetdb puppetdb && psql -c "create extension pg_trgm; create extension pg_stat_statements;" -d puppetdb && lein run services -c ./postgres.ini'
alias em="emacs"

plugins=(git go golang rbenv vagrant brew lein gem hub docker rust)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
. `brew --prefix`/etc/profile.d/z.sh

eval "$(rbenv init -)"

# Fixes an issue in Mountain Lion where the native PSQL
# interferes with running newer versions
export PATH="/usr/local/bin:$PATH"

export PROJECTS=$HOME/Projects
export GOPATH=$PROJECTS/go
export GOROOT=`go env GOROOT`
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH=$PATH:$PROJECTS/pe-testing/scripts

# For boot2docker/docker
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375
