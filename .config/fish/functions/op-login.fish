# Defined in - @ line 1
function op-login --wraps='eval (op signin my)' --description 'alias op-login eval (op signin my)'
  eval (op signin my) $argv;
end
