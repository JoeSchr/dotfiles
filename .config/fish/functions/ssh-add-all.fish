# Defined in - @ line 1
function ssh-add-all --wraps='ssh-add ~/.ssh/id_rsa_*' --description 'alias ssh-add-all=ssh-add ~/.ssh/id_rsa_*'
  ssh-add ~/.ssh/id_rsa_* $argv;
end
