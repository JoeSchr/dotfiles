# Defined in - @ line 1
function op-pw-grep --description alias\ op-pw-grep="op list items | grep \$1 | show field \$2"
  set -q argv[2]; or set argv[2] "password"
  op list items | jq ".[] | select (.overview.title | contains (\"$argv[1]\")) | .uuid" | xargs -I % sh -c "op get item % --fields $argv[2]; echo \"\"";
end
