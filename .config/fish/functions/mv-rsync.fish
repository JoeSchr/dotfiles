# Defined in - @ line 1
function mv-rsync --wraps='rsync -avzh --remove-source-files --progress ' --description 'alias mv-rsync rsync -avzh --remove-source-files --progress '
  rsync -avzh --remove-source-files --progress  $argv;
end
