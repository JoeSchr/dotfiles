# Defined in - @ line 1
function config --wraps='git --git-dir=/home/joe/.cfg/ --work-tree=/home/joe' --description 'alias config=git  --git-dir=/home/joe/.cfg/ --work-tree=/home/joe'
  git --git-dir=/home/joe/.cfg/ --work-tree=/home/joe $argv;
end
