#! /bin/bash

mkdir ~/Downloads
mkdir ~/.config
touch ~/.vimrc.local
touch ~/.bashrc.local
touch ~/.config/Xresources.local

## Adds current GIT
sudo add-apt-repository ppa:git-core/ppa -y

## Adds to APT repository
# lazygit
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68CCF87596E97291
#sudo add-apt-repository ppa:lazygit-team/release

# launchpad for appgrid (gallium os needed?)
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 241FE6973B765FAE

# vscode
curl -sSL https://packages.microsoft.com/keys/microsoft.asc -o microsoft.asc | sudo apt-key add
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"  | sudo tee /etc/apt/sources.list.d/vscode.list

# signal
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

sudo apt update

#sudo galliumos-update
sudo apt dist-upgrade

# install ALL THE THINGS
# essentials
sudo apt install -y neovim git tig mosh python3 python3-pip xsel htop xbacklight ssh-askpass lxappearance maim xcompmgr unclutter neomutt urlview notmuch zathura xcape stterm surf xtitle groff groff-base dbus-x11 compton xauth fish

# install OH-MY-FISH
cd ~/Downloads
git clone -c core.autocrlf=false https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
bin/install --offline

# code & signal
sudo apt install -y signal-desktop code
# fonts
sudo apt install -y fonts-symbola fonts-noto-hinted fonts-powerline fonts-inconsolata fonts-hack

# buildtools & dependencies
sudo apt install -y debian-keyring autoconf automake flex bison gdb libstdc++-7-doc ctags vim-scripts ninja-build gettext libtool libtool-bin cmake g++ pkg-config unzip xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev gcc make cmake glib-2.0 libncurses5-dev libncursesw5-dev bison cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev libxkbcommon-x11-dev python-xcbgen xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev libxcb-ewmh2 libx11-dev libxft-dev fontconfig isync msmtp pass libxinerama-dev apt-file


# TODO download .ssh/ folder
chmod 600 .ssh/*


#config push --set-upstream origin master

locale-gen en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
#cli for dpkg-reconfigure locales
sudo update-locale LANG=en_US.UTF_8
# installs clang
cd ~/Downloads
wget http://releases.llvm.org/9.0.0/clang+llvm-9.0.0-armv7a-linux-gnueabihf.tar.xz
tar -xvf clang+llvm-9.0.0-armv7a-linux-gnueabihf.tar.xz
rm clang+llvm-9.0.0-armv7a-linux-gnueabihf.tar.xz
mv clang+llvm-9.0.0-armv7a-linux-gnueabihf clang_9.0.0
sudo mv clang_9.0.0 /usr/local

#install dwm
# cd ~/Downloads
# sudo apt build-dep dwm
# sudo apt install libxcb-res0-dev
# git clone https://gitlab.com/zanc/xft
# cd xft
# autoreconf -f -i
# ./configure && sudo make install
# sudo ldconfig
# cd ..l
# git clone https://github.com/LukeSmithxyz/dwm.git
# cd dwm
# make && sudo make install

# cd ~/Downloads
# git clone https://github.com/LukeSmithxyz/dwmblocks.git
# cd dwmblocks
# make && sudo make install

cd ~/Downloads
git clone https://github.com/LukeSmithxyz/dmenu.git
cd dmenu
make && sudo make install

# install xserver and xinit and display manage
sudo apt install -y xserver-xorg x11-xserver-utils xinit xserver-xorg-legacy
# add user to tty group
sudo usermod -a -G tty `whoami`
#install bspwm, polybar and sxhkd
cd ~/Downloads/

# sxhkd
git clone https://github.com/baskerville/sxhkd.git
cd sxhkd/
make
sudo make install
cd ..

# polybar
# git clone https://github.com/polybar/polybar.git
# cd polybar/
# ./build.sh

# BSPWM
git clone https://github.com/baskerville/bspwm.git
cd bspwm/
make
sudo make install
sudo cp contrib/freedesktop/bspwm.desktop /usr/share/xsessions/
cd ..

sudo cp $HOME/.local/bin/bspwm.desktop /usr/share/xsessions/bspwm.desktop
sudo ln -s $HOME/.local/bin/launch_bspwm /usr/local/bin/launch_bspwm
sudo ln -s $HOME/.local/bin/kde-bspwm.sh /usr/local/bin/kde-bspwm

# picom
sudo ln -s .config/xdg/picom.conf  /etc/xdg/picom.conf

# tmux
cd ~/Downloads
git clone https://github.com/tmux/tmux.git
# tmux dependecies libevent ncurses yacc/bison
alias yacc="bison"
wget https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz
tar -xzf libevent-2.1.11-stable.tar.gz
mv libevent-2.1.11-stable libevent
cd libevent
./configure
make
# make verify   # (optional)
sudo make install
cd ..

# install tpm
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# install tmux
cd tmux
sh autogen.sh
./configure && make && sudo mv ./tmux /usr/bin
cd ..

# docker
sudo apt-get remove docker docker-engine docker.io containerd runc
cd ~/Downloads
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# add user to docker group so we can run it without sudo
sudo groupadd docker
sudo usermod -aG docker $USER

# nvm node-js yarn
cd ~/Downloads
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
mkdir ~/.nvm
bash install_nvm.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 12
nvm use 12
nvm alias default 12
nvm use default
npm install --global yarn
cd ~
rm -rf node_modules/
rm yarn.lock

# neovim (latest)
cd ~/Downloads
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
# sets accesss rights so normal user can start it
sudo chown $USER  /usr/bin/nvim
sudo chown $USER  /usr/local/bin/nvim

# neovim support
yarn global add neovim
pip3 install --user pynvim
# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
# start for inital plugin setup
nvim &

# st
# harfbuzz (st dependencies)
cd ~/Downloads
git clone https://github.com/harfbuzz/harfbuzz
cd harfbuzz
./autogen.sh
make
sudo make install


cd ~/Downloads
git clone https://github.com/LukeSmithxyz/st
cd st
sudo make install
cd ~/Downloads

# mpd with google music
pip3 install --user mopidy

# muttwizard
cd ~/Downloads/
git clone https://github.com/LukeSmithxyz/mutt-wizard
cd mutt-wizard
sudo make install
cd ~/Downloads/

# pywal
pip3 install --user pywal
sudo apt install sxiv

# lazygit
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# lf - file manager
cd ~/Downloads
wget https://github.com/gokcehan/lf/releases/download/r13/lf-linux-amd64.tar.gz -O lf-linux-amd64.tar.gz
tar xvf lf-linux-amd64.tar.gz
chmod +x lf
sudo mv lf /usr/local/bin
cd ~/Downloads

# powerline fonts
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# zerotier
cd ~/Downloads
curl -s https://install.zerotier.com | sudo bash
sudo /usr/sbin/zerotier-one -d
sudo zerotier-cli join 1d71939404630533


# mosh requirements
cd Downloads
git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf
git submodule update --init --recursive
./autogen.sh
./configure
make
make check
sudo make install
sudo ldconfig # refresh shared library cache.

# mosh
cd ~/Downloads
git clone https://github.com/mobile-shell/mosh
cd mosh
./autogen.sh
./configure
make
sudo make install

# don't remove it, because we need some of this I think
# sudo apt remove -y xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev gcc make cmake pkg-config glib-2.0 autoconf automake pkg-config libncurses5-dev libncursesw5-dev bison cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev libxcb-ewmh2


## CLEANUP
sudo apt autoremove -y

cd ~

# TWEAKS
  # increase numer of file watcher
  echo fs.inotify.max_user_watches=160384 | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p

# docker (refresh group)
# needs to be at end, because it sources .bashrc again
newgrp docker
