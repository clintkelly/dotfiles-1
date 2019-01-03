#!/usr/bin/env bash
set -eu -o pipefail

DIR="$(cd "$(dirname "$0")"; pwd)"

if uname -a | grep -qi 'Darwin'; then
  echo 'macOS detected.'
  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
  defaults write -g com.apple.swipescrolldirection -bool FALSE


  which brew > /dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo 'Updating homebrew...'
  #brew update

  echo 'Installing git...'
  which git > /dev/null 2>&1 || brew install git

  echo 'Installing fish...'
  which fish > /dev/null 2>&1 || brew install fish
  mkdir -p ~/.config
  ln -fs "$DIR/config/fish" ~/.config/.

  echo 'Installing core utils...'
  which gls > /dev/null 2>&1 || brew install coreutils


  #echo 'Installing zsh...'
  #which zsh > /dev/null 2>&1 || brew install zsh zsh-completions

  echo 'Setting the login shell to fish...'
  sudo sh -c "grep -qi \"$(which fish)\" /etc/shells || echo \"$(which fish)\" >> /etc/shells"
  sudo chsh -s "$(which fish)" "$(whoami)"

  #echo 'Installing oh-my-zsh...'
  #rm -rf ~/.oh-my-zsh.old
  #if [ -d ~/.oh-my-zsh ]; then
	  #mv -f ~/.oh-my-zsh ~/.oh-my-zsh.old
  #fi
  #git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  #echo 'Installing powerline-fonts...'
  #git clone https://github.com/powerline/fonts.git
  #cd fonts
  #./install.sh
  #cd ..
  #rm -rf fonts

  echo 'Installing tmux...'
  which tmux > /dev/null 2>&1 || brew install tmux reattach-to-user-namespace

  echo 'Installing neovim...'
  which nvim > /dev/null 2>&1 || brew install neovim/neovim/neovim

  echo 'Installing vim-plug...'
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  echo 'Downloading submodules...'
  (cd $DIR && git submodule update --init)

  echo 'Installing dotfiles...'
  if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
    mv -f ~/.tmux.conf ~/.tmux.conf.old
  fi
  ln -s "$DIR/tmux.conf" ~/.tmux.conf

  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    mv -f ~/.zshrc ~/.zshrc.old
  fi
  ln -s "$DIR/zshrc" ~/.zshrc

  rm -rf ~/.config/base16-shell
  mkdir -p ~/.config/base16-shell
  cp -r "$DIR/config/base16-shell" ~/.config/.

  rm -rf ~/.config/nvim
  mkdir -p ~/.config
  ln -s "$DIR/config/nvim" ~/.config

  echo 'Installing vim plugins...'
  nvim -c PlugInstall -c qa

  echo 'Installing color scheme...'
  cp "$DIR/base16-circus-scheme/circus/scripts/base16-circus.sh" ~/.config/base16-shell/scripts
  cp "$DIR/base16-circus-scheme/circus/colors/base16-circus.vim" ~/.local/share/nvim/plugged/base16-vim/colors

  echo 'Patching the vim color scheme to not set the background color...'
  echo 'This allows vim to use the background set by tmux, which is configured'
  echo 'to use a lighter background for panes that are not in focus.'
  sed -E -i.bak 's/[ \t]*let[ \t]+s:cterm00[ \t]*=.*$/let s:cterm00 = "none"/' ~/.local/share/nvim/plugged/base16-vim/colors/base16-circus.vim

  echo 'Setting base16-shell color scheme...'
  zsh -ic base16_circus

  echo 'Install tmux package manager'
  rm -rf ~/.config/tmux
  mkdir -p ~/.config/tmux
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

  echo 'Reloading tmux config...'
  tmux source-file ~/.tmux.conf || true

  echo 'Installing ripgrep...'
  which rg > /dev/null 2>&1 || brew install ripgrep

  echo 'Installing  Dropbox...'
  #brew cask install dropbox

  echo 'Installing useful stuff...'
  brew list hub &> /dev/null || brew install hub
  brew list python2 &> /dev/null || brew install python2
  brew list pyenv &> /dev/null || brew install pyenv
  brew list ruby &> /dev/null || brew install ruby
  brew list rbenv &> /dev/null || brew install rbenv
  sudo gem install tmuxinator
  brew list ag &> /dev/null || brew install ag

  echo 'Setting up Python...'
  pip2 install virtualenv
  pip2 install virtualenvwrapper
  pip2 install virtualfish

  echo 'Setting up Java...'
  #brew cask install java
  brew install caskroom/versions/java8
  brew list maven &> /dev/null || brew install maven

  echo 'Setting up other work stuff'
  brew list mysql &> /dev/null || brew install mysql
  brew list chromedriver &> /dev/null || brew cask install chromedriver
  brew list jq &> /dev/null || brew install jq
  brew list libev &> /dev/null || brew install libev
  brew list watch &> /dev/null || brew install watch
  curl -L 'https://raw.git.musta.ch/airbnb/sysops/master/optica_tools/optica?token=AAACYGZku20eDheZx11JMvt9OUonKK94ks5a83UqwA%3D%3D' -o /usr/local/bin/optica
  chmod a+x /usr/local/bin/optica

  echo 'Installing fisher and bass'
  #curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  fisher add edc/bass
  fisher add fnm

  # TODO: rbenv, rbenv-bundler

  # simpler alternative to find
  brew list fd &> /dev/null || brew install fd

  echo 'Done.'
  exit
fi

if uname -a | grep -qi 'Ubuntu'; then
  echo 'Ubuntu detected.'

  echo 'Updating package lists...'
  DEBIAN_FRONTEND=noninteractive sudo apt-get -y update

  echo 'Installing git...'
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -y git

  echo 'Installing zsh...'
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -y zsh

  echo 'Setting the login shell to zsh...'
  sudo chsh -s "$(which zsh)" "$(whoami)"

  echo 'Installing oh-my-zsh...'
  rm -rf ~/.oh-my-zsh.old
  mv ~/.oh-my-zsh ~/.oh-my-zsh.old
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  echo 'Installing powerline-fonts...'
  git clone https://github.com/powerline/fonts.git
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts

  echo 'Installing tmux...'
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -y tmux

  echo 'Installing neovim...'
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -y software-properties-common
  DEBIAN_FRONTEND=noninteractive sudo add-apt-repository -y ppa:neovim-ppa/unstable
  DEBIAN_FRONTEND=noninteractive sudo apt-get update -y
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -y neovim

  echo 'Installing vim-plug...'
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  echo 'Downloading submodules...'
  (cd $DIR && git submodule update --init)

  echo 'Installing dotfiles...'
  cp  "$DIR/.tmux.conf" ~/.tmux.conf
  #cp  "$DIR/.zshrc" ~/.zshrc
  rm -rf ~/.config/base16-shell
  mkdir -p ~/.config/base16-shell
  cp -r "$DIR/.config/base16-shell" ~/.config
  rm -rf ~/.config/nvim
  mkdir -p ~/.config/nvim
  cp -r "$DIR/.config/nvim" ~/.config

  echo 'Installing vim plugins...'
  nvim -c PlugInstall -c qa

  echo 'Installing color scheme...'
  cp "$DIR/base16-circus-scheme/circus/scripts/base16-circus.sh" ~/.config/base16-shell/scripts
  cp "$DIR/base16-circus-scheme/circus/colors/base16-circus.vim" ~/.local/share/nvim/plugged/base16-vim/colors

  echo 'Patching the vim color scheme to not set the background color...'
  echo 'This allows vim to use the background set by tmux, which is configured'
  echo 'to use a lighter background for panes that are not in focus.'
  sed -E -i.bak 's/[ \t]*let[ \t]+s:cterm00[ \t]*=.*$/let s:cterm00 = "none"/' ~/.local/share/nvim/plugged/base16-vim/colors/base16-circus.vim

  #echo 'Setting base16-shell color scheme...'
  #zsh -ic base16_circus

  echo 'Reloading tmux config...'
  tmux source-file ~/.tmux.conf || true

  echo 'Installing ripgrep...'
  curl -L -o ripgrep.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/0.5.1/ripgrep-0.5.1-x86_64-unknown-linux-musl.tar.gz
  mkdir ripgrep
  tar -xzf ripgrep.tar.gz -C ripgrep --strip-components=1
  sudo cp ripgrep/rg /usr/local/bin
  rm -rf ripgrep ripgrep.tar.gz

  echo 'Done.'
  exit
fi

echo 'This operating system is not supported.'
