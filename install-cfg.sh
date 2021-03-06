#! /bin/bash

# call with
# sudo pamac -Sy git which rsync
# curl -Lks https://github.com/JoeSchr/dotfiles/raw/master/install-cfg.sh | /bin/bash

git clone --bare https://github.com/JoeSchr/dotfiles.git $HOME/.cfg

config="$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME"

mkdir -p $HOME/.backup-cfg/.config/autostart/
$config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    $config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} rsync -av --relative --remove-source-files {} .backup-cfg/{}
fi;
$config checkout
$config config status.showUntrackedFiles no

touch ~/.vimrc.local
touch ~/.bashrc.local
mkdir -p ~/Downloads
. .bashrc
