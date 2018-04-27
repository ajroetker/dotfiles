# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="eastwood"

alias ag="ag --all-types --smart-case"
alias be="bundle exec"
alias emacs='open -a /Applications/Emacs.app $1'
alias hco="hub checkout"

plugins=(git hub go golang ruby gem bundler python vagrant lein boot2docker docker z rust)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
. `brew --prefix`/etc/profile.d/z.sh

# added by travis gem
[ -f /Users/aroetker/.travis/travis.sh ] && source /Users/aroetker/.travis/travis.sh

pbr_beaker() {
    if [ -z "${1}" ]; then
        echo "Need a sha/version to run with"
        return
    fi
    if [ -n "${2}" ]; then
        flag="--tests tests"
    fi
    SHA=${1} pe_dist_dir=http://enterprise.delivery.puppetlabs.net/2017.2/ci-ready S3_BUCKET_NAME=puppet-aws-opsworks-prototypes pe_ver=$(curl http://getpe.delivery.puppetlabs.net/latest/2017.2) PE_FAMILY=2017.2 bundle exec beaker --debug --hosts centos6-64backup.mdca-64restore.a-centos7-64.a --keyfile /Users/aroetker/.ssh/id_rsa-acceptance --load-path lib --pre-suite pre-suite --preserve-hosts always ${flag}
}
