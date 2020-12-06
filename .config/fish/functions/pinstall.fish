# Defined in - @ line 1
function pinstall --wraps='pikaur -Syu --needed --noconfirm' --description 'alias pinstall=pikaur -Syu --needed --noconfirm'
  pikaur -Syu --needed --noconfirm $argv;
end
