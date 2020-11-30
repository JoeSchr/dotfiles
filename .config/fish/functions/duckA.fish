# Defined in - @ line 1
function duckA --wraps='du -ckah * | sort -rh | head' --description 'alias duckA=du -ckah * | sort -rh | head'
  du -ckah * | sort -rh | head $argv;
end
