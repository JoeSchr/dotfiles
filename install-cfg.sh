#! /bin/bash

# call with
# curl -Lks https://bitbucket.org/JozephS/dotfiles/raw/master/install-cfg.sh | /bin/bash

git clone --bare https://bitbucket.org/JozephS/dotfiles.git $HOME/.cfg

config="$(which git) --git-dir=~/.cfg/ --work-tree=~"

mkdir -p ~/.config-backup
$config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    $config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} rsync -av --remove-source-files {} .config-backup/{}
fi;
$config checkout
$config config status.showUntrackedFiles no

touch ~/.vimrc.local
touch ~/.bashrc.local
mkdir ~/Downloads
source .bashrc
