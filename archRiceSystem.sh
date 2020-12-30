#! /bin/sh

mkdir ~/Downloads
mkdir ~/.config
touch ~/.vimrc.local
touch ~/.bashrc.local
touch ~/.config/Xresources.local

# update mirror-list
sudo pacman-mirrors -g

su -l
# update keydatabases
rm -R /etc/pacman.d/gnupg
rm -R /root/.gnupg
dirmngr </dev/null

pacman-key --init
pacman-key --populate archlinux manjaro
pacman-key --refresh-keys
# update databases
pacman -Fy
pacman -Syy

# install buildtools like eg. git make libffi glibc gcc
pacman -S --needed base-devel git ed

# exit su -l
exit

# install AUR helper:
# try automatic
pacman -Sy pikaur

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
pikaur -Sy neovim-git ripgrep nvm tmux git python3 python-pip mosh htop bash-completion fish fzf
pip3 install --user wheel pynvim

# podman
pikaur -S podman catatonit crun
# needed for cgroups
# see: https://wiki.archlinux.org/index.php/Podman
sudo touch /etc/sub{u,g}id
sudo  usermod --add-subuids 165536-231072 --add-subgids 165536-231072 $(whoami)
# add dockerhub
echo "[registries.search]
registries = ['docker.io']" | sudo tee -a /etc/containers/registries.conf

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# risky/estoric on arm
pikaur -Sy ntfs-3g-fuse

# install OH-MY-FISH
cd ~/Downloads
git clone -c core.autocrlf=false https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
bin/install --offline

# install FISHER
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'

# fzf
fish -c 'fisher install jethrokuan/fzf'


# NPM / YARN / NODE / NVM
nvm install --lts
nvm use --lts
nvm alias default 12
nvm use default
npm install -G yarn
cd ~
# install nvm for fish
mkdir -p ~/.local/share/nvm
fish -c 'fisher install jorgebucaran/nvm.fish'


#INSTALL GUI & RICE
# ESSENTIALS GUI
pikaur -Sy latte-dock-git visual-studio-code-bin signal-desktop cpupower-gui cpupower urlview zathura google-chrome
# RICE
pikaur -Sy nitrogen xorg-xbacklight x11-ssh-askpass maim neomutt urlview notmuch zathura xsurf xtitle groff dbus-x12 clang imagemagick mntray

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

# git clone https://github.com/LukeSmithxyz/dwm.git
# cd dwm
# make && sudo make install

# cd ~/Downloads/
# git clone https://github.com/LukeSmithxyz/mutt-wizard
# cd mutt-wizard
# sudo make install

# pywal
# pip3 install --user pywal

# mpd with google music
# pip3 install --user mopidy

# powerline fonts
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# CONFIGURE DWM
# sudo cp $HOME/.local/bin/dwm.desktop /usr/share/xsessions/dwm.desktop
# sudo ln -s $HOME/.local/bin/kde-dwm.sh /usr/local/bin/kde-dwm
# # picom
# sudo ln -s .config/xdg/picom.conf  /etc/xdg/picom.conf


# cd ~/Downloads
# git clone https://github.com/LukeSmithxyz/dwmblocks.git
# cd dwmblocks
# make && sudo make install

# cd ~/Downloads
# git clone https://github.com/LukeSmithxyz/dmenu.git
# cd dmenu
# make && sudo make install

# CONFIGURE BSPWM
# sudo cp $HOME/.local/bin/bspwm.desktop /usr/share/xsessions/bspwm.desktop
# sudo ln -s $HOME/.local/bin/launch_bspwm /usr/local/bin/launch_bspwm
# sudo ln -s $HOME/.local/bin/kde-bspwm.sh /usr/local/bin/kde-bspwm

# pikaur -Sy bspwm

# TWEAKS
# increase number of file watcher
echo fs.inotify.max_user_watches=1048576 | sudo tee -a /etc/sysctl.d/50-max_user_watches.conf && \
sudo sysctl -p

# fix ntfs-3g disk access on mount as user
sudo usermod -a -G disk (whoami)

# fix vscode signin isues
pikaur -Sy qtkeychain gnome-keyring

# fix .ssh
chmod 600 .ssh/*

# bluetooth a2dp
pikaur -Sy pulseaudio-bt-auto-enable-a2dp pulseaudio-bluetooth
# equalizer
pikaur -Sy pulseeffects
# unify for logitech setpoint
pikaur -Sy ltunify
# nvidia intel hybrid stuff
# sudo mhwd -i pci video-hybrid-intel-nvidia-450xx-prime
# pikaur -S cuda vulkan-mesa-layers vulkan-intel lib32-vulkan-intel  lib32-amdvlk  lib32-nvidia-utils  lib32-vulkan-mesa-layers
sudo mhwd -r pci video-nvidia-455xx                         00:18:41
sudo pikaur -S lib32-opencl-nvidia-455xx opencl-nvidia

# sudo pikaur -S nvidia-dkms-beta vulkan-mesa-layers lib32-vulkan-intel lib32-nvidia-utils-beta lib32-vulkan-mesa-layers

# OPEN SHIFT
# Minishift & OC Cli
pikaur -Sy minishift origin-client
# ODO Cli
sudo curl -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64 -o /usr/local/bin/odo
sudo chmod +x /usr/local/bin/odo

# nordvpn
sudo groupadd -r nordvpn
pikaur -Syu nordvpn-bin
sudo systemctl enable --now nordvpnd.service
sudo gpasswd -a $(whoami) nordvpn

# CUSTOM KERNEL

## xenomod
pikaur -S linux-manjaro-xanmod linux-manjaro-xanmod-headers
sudo ln -s /usr/src/linux-manjaro-xanmod  /usr/src/linux

# install beta, because of DKMS
pikaur -Sy nvidia-beta-dkms xorg-server-devel lib32-nvidia-utils-beta nvidia-settings-beta opencl-nvidia-beta


# DOCKER (REFRESH GROUP)
# needs to be at end, because it sources .bashrc again
# DOCKER
sudo groupadd docker
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker
sudo systemctl start docker
sudo chown $(id -u):$(id -g) /var/run/docker.sock

newgrp docker
cd
