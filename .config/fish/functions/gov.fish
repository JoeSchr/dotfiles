# Defined in - @ line 1
function gov --wraps='git lg --date=short --all' --description 'alias gov git lg --date=short --all'
  git lg --date=short --all $argv;
end
