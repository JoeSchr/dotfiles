# Defined in - @ line 1
function g --wraps=git --description 'alias g=git'
  GIT_WORK_TREE=(pwd) git $argv;
end
