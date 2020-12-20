# Defined in - @ line 1
function reboot-linux --wraps='sudo grub-reboot "Manjaro Linux"' --description 'alias reboot-linux=sudo grub-reboot "Manjaro Linux"'
  sudo grub-reboot "Manjaro Linux";
end
