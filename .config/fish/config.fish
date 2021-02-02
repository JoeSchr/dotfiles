fish_vi_key_bindings

# C-p completes history expand
bind -M insert \cP forward-char
# C-f moves one word forward
bind -M insert \cF nextd-or-forward-word

if status --is-interactive
  echo -n Setting abbreviations...
  set -g fish_user_abbreviations
  abbr g 'git'
  abbr 'gri' 'git rebase --rebase-merges -i'
  abbr ga 'git add -p'
  abbr gs 'git status'
  abbr gov 'git lg --all'
  abbr cng 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  abbr e 'nvim'
  alias e 'nvim'
  abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
  abbr pinstall 'pikaur -Syu --needed --noconfirm'
  abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
  abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
  abbr yay 'pikaur'
  abbr rg 'rg -S'
  abbr mail 'cmdg'
  alias pbcopy 'xsel --clipboard --input'
  alias pbpaste 'xsel --clipboard --output'

  echo -n Setting exports...
  set -x PAGER less
  set -x EDITOR nvim
  set -x VISUAL nvim
  # always try to set DISPLAY
  set -q DISPLAY; or set DISPLAY ":0"
  abbr psa 'ps ax | grep'
end
