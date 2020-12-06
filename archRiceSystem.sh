mkdir ~/Downloads
mkdir ~/.config
touch ~/.vimrc.local
touch ~/.bashrc.local
touch ~/.config/Xresources.local

# update mirror-list
sudo pacman-mirrors -g
# update databases
sudo pacman -Fy
sudo pacman -Syy

# install buildtools like eg. git make libffi glibc gcc
sudo pacman -S --needed base-devel git

# install AUR helper:
# try automatic
pikaur -Sy pikaur

# manual
cd ~/Downloads
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri
cd ~/Downloads


# upgrade all the packages!!!
sudo pikaur -Syu

# install manjaro pacman
pikaur -Sy pamac

# ESSENTIALS SYSTEM
pikaur -Sy neovim nvm tmux git docker docker-compose python3 python-pip mosh htop bash-completion duf fish

# install OH-MY-FISH
cd ~/Downloads
git clone -c core.autocrlf=false https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
bin/install --offline


# risky/estoric on arm
pikaur -Sy ntfs-3g-fuse lf

# NPM / YARN / NODE / NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
nvm use --lts
nvm alias default 12
nvm use default
npm install -G yarn
cd ~

# install FISHER
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# install nvm for fish
fisher install jorgebucaran/nvm.fish

# VIM
pikaur -Sy neovim-nigthly ripgrep fzf
pip3 install --user wheel pynvim

#INSTALL GUI & RICE
# ESSENTIALS GUI
pikaur -Sy visual-studio-code-bin signal-desktop xsel latte-dock cpupower

# RICE
pikaur -Sy nitrogen xorg-xbacklight x11-ssh-askpass maim xcompmgr picom unclutter neomutt urlview notmuch dunst zathura xcape surf xtitle groff dbus-x12 clang imagemagick

# FONTS
pikaur -Sy noto-fonts powerline-fonts ttf-inconsolata ttf-joypixels nerd-fonts-hack

cd ~/Downloads

# ST
# dependencies
# pikaur -Sy libxcb libxft-bgra-git
# pikaur -Sy st-luke-git
# cd ~/Downloads
# git clone https://github.com/LukeSmithxyz/st
# cd st
# sudo make install
# cd ~/Downloads

git clone https://github.com/LukeSmithxyz/dwm.git
cd dwm
make && sudo make install

cd ~/Downloads/
git clone https://github.com/LukeSmithxyz/mutt-wizard
cd mutt-wizard
sudo make install

# pywal
pip3 install --user pywal

# mpd with google music
pip3 install --user mopidy

# powerline fonts
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# CONFIGURE DWM
sudo cp $HOME/.local/bin/dwm.desktop /usr/share/xsessions/dwm.desktop
sudo ln -s $HOME/.local/bin/kde-dwm.sh /usr/local/bin/kde-dwm
# picom
sudo ln -s .config/xdg/picom.conf  /etc/xdg/picom.conf


cd ~/Downloads
git clone https://github.com/LukeSmithxyz/dwmblocks.git
cd dwmblocks
make && sudo make install

cd ~/Downloads
git clone https://github.com/LukeSmithxyz/dmenu.git
cd dmenu
make && sudo make install

# CONFIGURE BSPWM
sudo cp $HOME/.local/bin/bspwm.desktop /usr/share/xsessions/bspwm.desktop
sudo ln -s $HOME/.local/bin/launch_bspwm /usr/local/bin/launch_bspwm
sudo ln -s $HOME/.local/bin/kde-bspwm.sh /usr/local/bin/kde-bspwm

pikaur -Sy bspwm

# TWEAKS
# increase number of file watcher
echo fs.inotify.max_user_watches=1048576 | sudo tee -a /etc/sysctl.d/50-max_user_watches.conf && \
sudo sysctl -p

# fix ntfs-3g disk access on mount as user
sudo usermod -a -G disk $(whoami)

# fix vscode signin isues
pikaur -Sy qtkeychain gnome-keyring

# fix .ssh 
chmod 600 .ssh/*

# DOCKER
sudo groupadd docker
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker
sudo systemctl start docker
sudo chown $(id -u):$(id -g) /var/run/docker.sock

# bluetooth a2dp
pikaur -Sy pulseaudio-bt-auto-enable-a2dp pulseaudio-bluetooth
# equalizer
pikaur -Sy pulseeffects
# unify for logitech setpoint
pikaur -Sy ltunify
# nvidia intel hybrid stuff
sudo mhwd -i pci video-hybrid-intel-nvidia-450xx-prime
pikaur -S cuda vulkan-mesa-layers vulkan-intel lib32-vulkan-intel  lib32-amdvlk  lib32-nvidia-utils  lib32-vulkan-mesa-layers


# DOCKER (REFRESH GROUP)
# needs to be at end, because it sources .bashrc again
newgrp docker
cd
