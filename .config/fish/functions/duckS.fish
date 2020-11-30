# Defined in - @ line 1
function duckS --wraps='du -ckSh * | sort -rh | head' --description 'alias duckS=du -ckSh * | sort -rh | head'
  du -ckSh * | sort -rh | head $argv;
end
