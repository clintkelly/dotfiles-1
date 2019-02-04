set -x PATH /usr/local/bin $PATH
set -x EDITOR nvim

# Base16 Shell
if status --is-interactive
    eval sh $HOME/.config/base16-shell/scripts/base16-default-dark.sh
end

#setopt ignoreeof

alias reload!='source ~/.config/fish/config.fish'

alias readlink='greadlink'
alias history='history 1'
alias h='history | tail -n 50'
alias c='clear'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vim=nvim
alias vi=nvim
alias ls='gls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias hg='history | grep '

alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

alias certs="curl http://curl.haxx.se/ca/cacert.pem > /usr/local/etc/openssl/cert.pem"

set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"

set -x VIMCONFIG $HOME/.config/nvim
set -x VIMDATA $HOME/.local/share/nvim


set -x DATA_DIR $HOME/repos/data
set -x AFDEV_HOST i-0d76f5887468e4ff8.inst.aws.airbnb.com


set -x AFDEV_PORT 61977
set -x AFDEV_USER "clint_kelly"

set -x PATH $PATH $HOME/repos/sysops/optica_tools

set -x WORKON_HOME ~/.workon
eval (python -m virtualfish compat_aliases)
set -x VIRTUALFISH_HOME ~/.workon

# Eeek!
#source /usr/local/bin/virtualenvwrapper.sh

set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)

alias dc=docker-compose
bass source ~/.airlab/shellhelper.sh

set -x REMOTE_BUILDS y

# Set up rbenv
status --is-interactive; and source (rbenv init -|psub)
