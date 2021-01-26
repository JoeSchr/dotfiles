fish_vi_key_bindings

# C-p completes history expand
bind -M insert \cP forward-char
# C-f moves one word forward
bind -M insert \cF nextd-or-forward-word

echo -n Setting abbreviations...
if status --is-interactive
  set -g fish_user_abbreviations
  abbr g 'git'
  abbr ga 'git add -p'
  abbr gs 'git status'
  abbr gov 'git lg --all'
  abbr cng 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  abbr config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  abbr e 'nvim'
  alias e 'nvim'
  abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
  abbr pinstall 'pikaur -Syu --needed --noconfirm'
  abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
  abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
  abbr yay 'pikaur'
  abbr rg 'rg -S'
  alias pbcopy 'xsel --clipboard --input'
  alias pbpaste 'xsel --clipboard --output'
  end
