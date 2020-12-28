# Defined in - @ line 1
function reboot-win --wraps='sudo grub-reboot "Windows Boot Manager (on /dev/sdb1)"' --description 'alias reboot-win=sudo grub-reboot "Windows Boot Manager (on /dev/sdb1)"'
  sudo grub-reboot "Windows Boot Manager (on /dev/sdb1)";
  sudo systemctl reboot;
end
