# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# vi mode in bash!!!
set -o vi

export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/statusbar"
# adds pip bins to path
export PY_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')
export PY3_USER_BIN=="$(python3 -m site --user-base)/bin"
export PATH=$PY_USER_BIN:$PY3_USER_BIN:$PATH

#adds clang
export PATH=/usr/local/clang_9.0.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/clang_9.0.0/lib:$LD_LIBRARY_PATH

#adds nx/nomachine
export PATH=/usr/NX/bin:$PATH

# Use bash-completion, if available
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
. /usr/share/bash-completion/bash_completion

# Use git-completion, if available
if [ -f /usr/share/bash-completion/completions/git ]; then
. /usr/share/bash-completion/completions/git
fi
[[ $PS1 && -f /usr/share/bash-completion/completions/git ]] && \
. /usr/share/bash-completion/completions/git

if [ "$OS" == "Windows_NT" ]; then
  alias config="`which git` --git-dir=/c/Users/Joe/Insync/josef.schroecker@gmail.com/Dropbox/userconf/.dotfiles-cfg --work-tree=/c/Users/Joe/AppData/Roaming/.home"
  __git_complete config _git
  # Add tmux path (not working so far)
  export PATH="$PATH:/c/msys64/usr/bin/"
  . ~/.bashrc.win
else
  alias config="`which git`  --git-dir=$HOME/.cfg/ --work-tree=$HOME"
  __git_complete config _git
  alias config-changed="config checkout 2>&1 | egrep \s+\. | awk {'print $1'} | xargs -I{} echo {}"
  # alias config-changed="config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} git --git-dir=$HOME/.dotfiles-cfg/ --work-tree=$HOME add -- {}"

  . ~/.fzf.bash
  # show git branch with nice colors
  force_color_prompt=yes
  parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
  }
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\n\$ '
  #if [ "$color_prompt" = yes ]; then
  #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\n\$ '
  #else
  ##color_prompt if is not working on docker...
  #  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\n\$ '
  #fi
  unset color_prompt force_color_prompt
fi


SSH_ENV=$HOME/.ssh/environment

# important for `sudo -A`
export SUDO_ASKPASS="/home/joe/.local/bin/dmenupass"

# for docker postgraphile
export UID;

# e for edit
# vim is king
alias e="nvim"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export GUI_EDITOR=/usr/bin/nvim
export EDITOR="nvim"
export REACT_EDITOR=code

# Setting for the new UTF-8 terminal support in TMUX
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# start the ssh-agent
function start_agent {
        echo "Initializing new SSH agent..."
        # spawn ssh-agent
        /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
        echo succeeded
        chmod 600 "${SSH_ENV}"
        . "${SSH_ENV}" > /dev/null
        /usr/bin/ssh-add
}
if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
                start_agent;
        }
else
        start_agent;
fi

## csh: pass arguments to windows shell for execution
function csh {
        arg="$@"    # needs helper arg for double-quotes ""
        cmd "/C $arg"
}
## removes docker lock ups hardcore mode
docker-removecontainers() {
        docker stop $(docker ps -aq)
        docker rm $(docker ps -aq)
}

docker-armageddon() {
        docker-removecontainers
        docker network prune -f
        docker rmi -f $(docker images --filter dangling=true -qa)
        docker volume rm $(docker volume ls --filter dangling=true -q)
        docker rmi -f $(docker images -qa)
}


alias less='less -r'
# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color --show-control-chars'
alias ll='ls -alkh'

# ssh-add
alias ssh-add-all="ssh-add ~/.ssh/id_rsa_*"

## GIT ##
# now with autocomplete #
alias g="git"
# make autocomplete work with `g`
__git_complete g _git

# git status
alias gs='git status '
__git_complete gs _git_status

# git add
alias ga='git add '
__git_complete ga _git_add
alias gap='git add --patch '
__git_complete gap _git_add

# git better log
alias gl='git lg'
__git_complete gl _git_log
# git overview (all branches)
alias gov='git lg --date=short --all'
__git_complete gov _git_log

# git branches
alias gb='git branch '
__git_complete gb _git_branch

# git commit
alias gc='git ci '
__git_complete gc _git_commit

# git diff
alias gd='git diff'
__git_complete gd _git_diff

# git checkout
alias go='git checkout '
__git_complete go _git_checkout

alias gp='git push'
__git_complete gp _git_push


alias gk='gitk --all&'
alias gx='gitx --all'

# type safe
alias got='git '
__git_complete got _git
alias get='git '
__git_complete get _git

alias gpu='git pu  --rebase'
__git_complete gpu _git_pull

# after https://sandofsky.com/blog/git-workflow.html
alias gmsf='git merge --no-ff --no-commit '
__git_complete gmsf _git_merge
alias gms='git merge --squash '
__git_complete gms _git_merge
alias gmf='git feat  '
__git_complete gmf _git_merge
alias gm='git merge  '
__git_complete gm _git_merge
alias gr='git rebase  '
__git_complete gri _git_rebase
alias gri='git revise --interactive '
__git_complete gri _git_rebase
alias gbdr='git branch-delete-remote '
__git_complete gbdr _git_branch

# install git-revise
alias install-git-revise='sudo apt update && sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget  && curl -O https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz && tar -xf Python-3.7.3.tar.xz && cd Python-3.7.3 && ./configure --enable-optimizations --with-ensurepip=install  && make -j 8 && sudo make altinstall && python3.7 --version && pip3 install --user git-revise && git revise --version'

alias cls="clear"

# find largest folder/file quickly (seperated in subdirs)
alias duckS='du -ckSh * | sort -rh | head'
# find largest folder/file quickly (summarized)
alias ducks='du -cksh * | sort -rh | head'

# search also hidden files
alias duckA='du -ckah * | sort -rh | head'

# kill grep
function killgrep {
  echo kill $(ps aux | grep "$1" | awk '{print $2}');
  kill $(ps aux | grep "$1" | awk '{print $2}');
}
export -f killgrep

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Reboot directly to Windows
# Inspired by http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu
reboot_to_windows ()
{
    windows_title=$(grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "$windows_title" && sudo reboot
}
alias reboot-to-windows='reboot_to_windows'

# source local commands
. ~/.bashrc.local

# -- EXAMPLES BASHRC.LOCAL

# # needed to make X11 forward for electron apps work
# # see: https://github.com/electron/electron/issues/22775
# export QT_X11_NO_MITSHM=1

# ## TMUX
# alias tmux-init="tmux attach -t base || tmux new -s base"

# ## POSTGRAPHILE DOCKER
# export PG_DUMP="docker-compose exec -T db pg_dump"

# ## ALIASES
# # show battery
# alias battery="acpi -b"

# alias pip="pip3"

# search stackoverflow with googler
#alias so='googler -j -w stackoverflow.com (xsel)'

# ## default start tmux, with option to break
# # exit if inside tmux
# if [[ "$TERM" =~ "screen".* ]]; then
#   echo "Already inside TMUX"
# else
#
#   read -t 3 -n 1 -p "Start tmux (n/Y)? " answer
#   [ -z "$answer" ] && answer="Y"  # 'yes' efault choice
#   echo
#   case ${answer:0:1} in
#       n|N )
#           echo "No Tmux"
#           ;;
#       * )
#           echo "Starting tmux-init"
#           tmux attach -t base || tmux new -s base
#       ;;
#   esac
# fi
#
## FIX on WSL so it doesn't get windows npm/yarn
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Program Files\/nodejs://')
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Program Files\/nodejs\/://')
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Users\/Joe\/AppData\/Roaming\/npm://')
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Program Files (x86)\/Yarn\/bin\/://')
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Users\/Joe\/AppData\/Local\/Yarn\/bin://')

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export TERMINAL=st
# export BROWSER=chrome
