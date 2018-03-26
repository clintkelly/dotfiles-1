# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Don't display user@host in the prompt if we are this user.
DEFAULT_USER="$(whoami)"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Only show the last component of the path.
prompt_dir() {
  prompt_segment blue black '%1~'
}

# We use C-d to scroll in tmux and nvim, so turn this option off to prevent
# us from accidentally terminating the shell with it.
setopt ignoreeof

# emacs keybindings
bindkey -e

# Other keybindings
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word

# base16-shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true

# Local configuration
[ -f ~/.zshrc-local ] && source ~/.zshrc-local || true

alias reload!='. ~/.zshrc'

alias readlink='greadlink'
alias history='history 1'
alias h='history | tail -n 50'
alias c='clear'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vim=nvim
alias vi=nvim
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias hg='history | grep '

alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

alias certs="curl http://curl.haxx.se/ca/cacert.pem > /usr/local/etc/openssl/cert.pem"

# -----------------------------------------------------------------------------
# Custom stuff from Clint

# Fix ridiculous ulimit.
#ulimit -S -n 16384

# Explicitly set JAVA_HOME
#JAVA_HOME=$(/usr/libexec/java_home)
#export JAVA_HOME=$JAVA_HOME

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PYENV_ROOT=/usr/local/opt/pyenv
eval "$(pyenv init -)"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
eval "$(hub alias -s)"

export PATH="$PATH:$HOME/anaconda3/bin"
#
export VIMCONFIG=$HOME/.config/nvim
export VIMDATA=$HOME/.local/share/nvim

# Bindings to search history for lines matching current line up to cursor
bindkey '^xp' history-beginning-search-backward
bindkey '^xn' history-beginning-search-forward

# -----------------------------------------------------------------------------
# Fiddle around with named directories
hash -d dotfiles=~/.dotfiles

# -----------------------------------------------------------------------------
# afdev stuff
# afdev
export DATA_DIR=$HOME/repos/data #PATH WHERE YOU CLONED THE DATA REPO
export AFDEV_HOST="i-0f05a04cca3b622de.inst.aws.airbnb.com" #CHOOSE A DIFFERENT HOST
export AFDEV_PORT=61903 #CHOOSE A DIFFERENT PORT
# optional
export AFDEV_USER="clint_kelly"

function redsync {
  rsync -vv -azP ${1}/ ${AFDEV_HOST}:~/${1}
}

export PATH="$PATH:$HOME/repos/sysops/optica_tools"
