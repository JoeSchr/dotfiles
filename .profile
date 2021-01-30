# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# adds pip bins to path
export PY_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')
export PY3_USER_BIN=="$(python3 -m site --user-base)/bin"
export PATH=$PY_USER_BIN:$PY3_USER_BIN:$PATH


# Setting for the new UTF-8 terminal support in TMUX
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# wanted by `systemctl enable --user ssh-agent`
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# SOURCE LOCAL
[ -e $HOME/.profile.local ] && . $HOME/.profile.local

# EXAMPLE for .profile.local
# # vim is king
# export EDITOR=$(which nvim)
# export VISUAL=$(which nvim)
# export GUI_EDITOR=$(which goneovim)
# export REACT_EDITOR=$(which code)
##adds nx/nomachine
# [ -s "/usr/NX/bin" ] && export PATH=/usr/NX/bin:$PATH

##adds clang
#export PATH=/usr/local/clang_9.0.0/bin:$PATH
#export LD_LIBRARY_PATH=/usr/local/clang_9.0.0/lib:$LD_LIBRARY_PATH

# export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
## NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ## EXPORTS
# # needed to make X11 forward for electron apps work
# # see: https://github.com/electron/electron/issues/22775
# export QT_X11_NO_MITSHM=1
# POSTGRAPHILE DOCKER
# export PG_DUMP="docker-compose exec -T db pg_dump"
#
# export LANGUAGE=en_US.UTF-8
# export LANG=en_US.UTF-8
#
# # important for `sudo -A`
# export SSH_ASKPASS='/usr/bin/ksshaskpass'
# for docker postgraphile
# export UID;
# NVIDIA
# export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
