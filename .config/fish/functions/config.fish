# Defined in - @ line 1
function config --wraps='git --git-dir=$HOME/.cfg/ --work-tree=$HOME/gc' --description 'alias config=git  --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv;
end
