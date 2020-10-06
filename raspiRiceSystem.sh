sudo apt-get update
sudo apt install curl libx11-6 libxext6 libegl1-mesa zlib1g libstdc++6 libgl1-mesa-dri libasound2 libpulse0 libcom-err2 libgmp10 libp11-kit0
curl -L https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/appimage/Minecraft_Bedrock_Launcher-armhf.0.0.540.AppImage --output MC.AppImage
chmod +x MC.AppImage
./MC.AppImage


# VS Code raspi
wget -qO - https://packagecloud.io/headmelted/codebuilds/gpgkey | sudo apt-key add -
wget -O - https://code.headmelted.com/installers/apt.sh | sudo bash

#TWEAKS
  # first install all required software

  TWEAK_REQUIRED=raspberrypi-ui
  # ui tools
  TWEAK_REQUIRED=$TWEAK_REQUIRED wpagui
  #bluetooth
  TWEAK_REQUIRED=$TWEAK_REQUIRED pulseaudio-module-bluetooth pulseaudio

  # frees 2G+
  sudo apt-get purge wolfram-engine

  # install all TWEAK_REQUIRED once
  sudo apt install --no-install-recommends -y  $TWEAK_REQUIRED

  # CONFIG

  #bluetooth enable headset
  sudo usermod -G bluetooth -a $(whoami)
  sudo sed -i 's/^\(ExecStart=.*\)/\1--noplugin=sap/' /lib/systemd/system/bluetooth.service
  echo "ExecStartPre=/bin/sleep 2" | sudo tee -a /lib/systemd/system/bthelper@.service
  cat << EOT >> ~/.asoundrc
    # Bluetooth headset
    defaults.bluealsa {
      interface "hci0" # host Bluetooth adapter
      device "E8:AB:FA:38:3C:3A"
      profile "a2dp"
    }
  EOT

  sudo systemctl status bluetooth.service

  # REBOOT
  sudo reboot
