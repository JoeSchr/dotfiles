#! /bin/fish

mkdir ~/Downloads
mkdir ~/.config
touch ~/.vimrc.local
touch ~/.bashrc.local
touch ~/.config/Xresources.local


su -l
# update mirror-list
pacman-mirrors -g
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
pacman -S --noconfirm --needed base-devel git ed python python-pip

# exit su -l
exit

# install AUR helper:
# try automatic
pamac -S pikaur

# manual
pip install --user commonmark wheel pyalpm
cd ~/Downloads
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri
cd ~/Downloads


# upgrade all the packages!!!
pikaur -Syyu

# install manjaro pacman
pikaur -Sy pamac

# ESSENTIALS SYSTEM
pikaur -S --noconfirm neovim-git ripgrep nvm tmux urlview python3 python-pip mosh htop bash-completion fish fzy fzf nodejs
pip3 install --user wheel pynvim
# risky/estoric on arm
pikaur -S  ntfs-3g-fuse



# FISH DEFAULT SHELL

# 1. Copy this file to /usr/local/bin/fishlogin
sudo ln -s ~/.local/bin/fishlogin /usr/local/bin/fishlogin
# 2. Make it executable:
sudo chmod +x /usr/local/bin/fishlogin
# 3. Add it to /etc/shells
echo /usr/local/bin/fishlogin | sudo tee -a /etc/shells
# 4. Switch your login shell
chsh -s /usr/local/bin/fishlogin $USER
# source: https://superuser.com/a/1046884

# FISHER
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'

# omf
fish -c 'fisher install oh-my-fish/oh-my-fish'
# omf theme
fish -c 'omf install yimmy'
# fzf
fish -c 'fisher install gyakovlev/fish-fzy'

# MANUAL: install OH-MY-FISH
# cd ~/Downloads
 git clone -c core.autocrlf=false https://github.com/oh-my-fish/oh-my-fish
 cd oh-my-fish
 bin/install --offline

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
# ESSENTIALS DESKTOP
pikaur -S --noconfirm latte-dock-git signal-desktop cpupower-gui cpupower google-chrome zathura
# RICE
pikaur -S --noconfirm mntray ytmdesktop appmenu-gtk-module
# VSCODE
pikaur -S --noconfirm visual-studio-code-bin

# FONTS
pikaur -Sy noto-fonts powerline-fonts ttf-inconsolata ttf-joypixels nerd-fonts-hack
# powerline fonts
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
cd ~/Downloads

# DOCKER/PODMAN
pikaur -S --noconfirm podman catatonit crun
# needed for cgroups
# see: https://wiki.archlinux.org/index.php/Podman
sudo touch /etc/sub{u,g}id
sudo  usermod --add-subuids 165536-231072 --add-subgids 165536-231072 (whoami)
# add dockerhub
echo "[registries.search]
registries = ['docker.io']" | sudo tee -a /etc/containers/registries.conf

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-(uname -s)-(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# TA-LIB
cd ~/Downloads \
  && wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
  && tar -xzf ta-lib-0.4.0-src.tar.gz \
  && rm ta-lib-0.4.0-src.tar.gz \
  && cd ta-lib/ \
  && sudo ./configure --prefix=/usr \
  && sudo make \
  && sudo make install \
  && cd .. \
  && mv ta-lib/ ~/.local/sources/ta-lib \
  && pip install ta-lib

# TWEAKS
# increase number of file watcher
echo fs.inotify.max_user_watches=1048576 | sudo tee -a /etc/sysctl.d/50-max_user_watches.conf && sudo touch /etc/sysctl.conf && sudo sysctl -p

# fix ntfs-3g disk access on mount as user
sudo usermod -a -G disk (whoami)

# fix vscode signin isues
pikaur -S --nonconfirm qtkeychain gnome-keyring

# fix .ssh
chmod 600 .ssh/*

# bluetooth a2dp
# pikaur -Sy pulseaudio-bt-auto-enable-a2dp pulseaudio-bluetooth
# equalizer
pikaur -Sy pulseeffects
# unify for logitech setpoint
pikaur -S --noconfirm ltunify
# NVIDIA INTEL HYBRID STUFF
# sudo mhwd -i pci video-hybrid-intel-nvidia-450xx-prime
# pikaur -S cuda vulkan-mesa-layers vulkan-intel lib32-vulkan-intel  lib32-amdvlk  lib32-nvidia-utils  lib32-vulkan-mesa-layers
# sudo mhwd -r pci video-nvidia-455xx
# sudo pikaur -S lib32-opencl-nvidia-455xx opencl-nvidia

# sudo pikaur -S nvidia-dkms-beta vulkan-mesa-layers lib32-vulkan-intel lib32-nvidia-utils-beta lib32-vulkan-mesa-layers

# OPEN SHIFT
# Minishift & OC Cli
pikaur -Sy minishift origin-client
# ODO Cli
sudo curl -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64 -o /usr/local/bin/odo
sudo chmod +x /usr/local/bin/odo

# openshift crc
# install `crc` first from here:
# https://access.redhat.com/documentation/en-us/red_hat_codeready_containers/1.20/html/getting_started_guide/using-codeready-containers_gsg
# https://wiki.archlinux.org/index.php/OpenShift#openshift_v4

# INSTALL
pikaur -S libvirt qemu qemu-arch-extra
sudo pacman -Syu ebtables dnsmasq
sudo systemctl restart libvirtd
# CRC SETUP
crc setup
crc start

# nordvpn
sudo groupadd -r nordvpn
pikaur -Syu nordvpn-bin
sudo systemctl enable --now nordvpnd.service
sudo gpasswd -a $(whoami) nordvpn

# cmdg
cd ~/Downloads
git clone https://github.com/JoeSchr/cmdg.git ~/.local/sources/cmdg
cd ~/.local/sources/cmdg
go build ./cmd/cmdg
sudo cp cmdg /usr/local/bin
# press Ctrl-A u to open urls in mail
pikaur -S --noconfirm urlview
cd ~/Downloads

# CUSTOM KERNEL

## xenomod
gpg --receive-keys 38DBBDC86092693E
pikaur -S linux-manjaro-xanmod linux-manjaro-xanmod-headers
sudo ln -s /usr/src/linux-manjaro-xanmod  /usr/src/linux

# install beta, because of DKMS
pikaur -Sy nvidia-beta-dkms xorg-server-devel lib32-nvidia-utils-beta nvidia-settings-beta opencl-nvidia-beta


# DOCKER (REFRESH GROUP)
# needs to be at end, because it sources .bashrc again
# DOCKER
sudo groupadd docker
sudo usermod -aG docker (whoami)
sudo systemctl enable docker
sudo systemctl start docker
sudo chown (id -u):(id -g) /var/run/docker.sock
newgrp docker

cd ~/Downloads
cp /opt/google/chrome-remote-desktop/chrome-remote-desktop .
patch -i chrome-remote-desktop--use_existing_session.patch chrome-remote-desktop
sudo cp ./chrome-remote-desktop /opt/google/chrome-remote-desktop/chrome-remote-desktop
