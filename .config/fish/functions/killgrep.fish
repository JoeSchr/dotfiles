# Defined in - @ line 1
function killgrep --wraps='killall' --wraps=killall --description 'alias killall but easier'
  echo kill (ps aux | grep "$argv" | awk '{print $2}');
  kill (ps aux | grep "$argv" | awk '{print $2}');
end
