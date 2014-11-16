# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="eastwood"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias emacs="/usr/local/Cellar/emacs/24.3/bin/emacs"
alias ag="ag --all-types --smart-case"
alias phusion="phusion --password=digifreak1991"
alias be="bundle exec"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git go golang rbenv vagrant brew lein gem hub)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
eval "$(rbenv init -)"

# Fixes an issue in Mountain Lion where the native PSQL
# interferes with running newer versions
#export PATH="/usr/local/bin:$PATH:/Users/aroetker/bin"
#export JAVA_HOME=$(/usr/libexec/java_home)

export PROJECTS=$HOME/Projects
export GOPATH=$PROJECTS/go
export GOROOT=`go env GOROOT`
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH=$PATH:$PROJECTS/pe-testing/scripts

# For boot2docker/docker
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375
