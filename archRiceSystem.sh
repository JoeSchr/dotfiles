mkdir ~/Downloads
mkdir ~/.config
touch ~/.vimrc.local
touch ~/.bashrc.local
touch ~/.config/Xresources.local

# update databases
sudo pacman -Fy
sudo pacman -Syy

# install buildtools like eg. git make libffi glibc gcc
sudo pacman -S base-devel

# install YAY helper:
pamac install yay
# manual install YAY:
# _uid="$(id -u)"
# _uid="$(id -g)"
# cd /opt
# sudo git clone https://aur.archlinux.org/yay-git.git
# sudo chown -R $_uid:$_gid ./yay-git
# cd yay-git
# makepkg -si
# # 2 times to make it stick
# makepkg -si


# upgrade all the packages!!!
sudo yay -Syu

# install manjaro pacman
yay -Sy pamac

# ESSENTIALS SYSTEM
pamac update
pamac install neovim nvm tmux git docker docker-compose python3 python-pip mosh htop bash-completion duf
# risky/estoric on arm
yay -S ntfs-3g-fuse lf

# NPM / YARN / NODE / NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
nvm use --lts
nvm alias default 12
nvm use default
cd ~


# VIM
pamac install neovim-nigthly ripgrep fzf
pip3 install --user wheel pynvim


#INSTALL GUI & RICE
# ESSENTIALS GUI
pamac install visual-studio-code-bin signal-desktop xsel latte-dock

# RICE
pamac install nitrogen xorg-xbacklight x11-ssh-askpass maim xcompmgr picom unclutter neomutt urlview notmuch dunst zathura xcape surf xtitle groff dbus-x12 clang imagemagick

# FONTS
pamac install noto-fonts powerline-fonts ttf-inconsolata ttf-joypixels
yay -S nerd-fonts-hack

cd ~/Downloads


# dependencies
pamac install libxcb
yay -S libxft-bgra-git

# ST
pamac install st-luke-git
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

pamac install bspwm

# TWEAKS
# increase number of file watcher
echo fs.inotify.max_user_watches=1048576 | sudo tee -a /etc/sysctl.d/50-max_user_watches.conf && \
sudo sysctl -p

# fix ntfs-3g disk access on mount as user
sudo usermod -a -G disk $(whoami)

# fix vscode signin isues
yay -S qtkeychain gnome-keyring

chmod 600 .ssh/*

# DOCKER
sudo groupadd docker
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker
sudo systemctl start docker
sudo chown $(id -u):$(id -g) /var/run/docker.sock

# bluetooth a2dp
pamac install pulseaudio-bt-auto-enable-a2dp pulseaudio-modules-bt
# equalizer
pamac install pulseeffects
# unify for logitech setpoint
pamac install ltunify


# DOCKER (REFRESH GROUP)
# needs to be at end, because it sources .bashrc again
newgrp docker
cd
