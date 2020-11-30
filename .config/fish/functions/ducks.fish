# Defined in - @ line 1
function ducks --wraps='du -cksh * | sort -rh | head' --description 'alias ducks=du -cksh * | sort -rh | head'
  du -cksh * | sort -rh | head $argv;
end
