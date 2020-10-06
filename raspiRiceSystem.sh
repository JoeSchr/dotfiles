sudo apt-get update
sudo apt install curl libx11-6 libxext6 libegl1-mesa zlib1g libstdc++6 libgl1-mesa-dri libasound2 libpulse0 libcom-err2 libgmp10 libp11-kit0
curl -L https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/appimage/Minecraft_Bedrock_Launcher-armhf.0.0.540.AppImage --output MC.AppImage
chmod +x MC.AppImage
./MC.AppImage


# VS Code raspi
wget -O - https://code.headmelted.com/installers/apt.sh | sudo bash

#TWEAKS

  sudo apt install --no-install-recommends -y raspberrypi-ui-mods wpagui

  # bluetooth
  sudo usermod -G bluetooth -a $(whoami)
  # frees 2G+
  sudo apt-get purge wolfram-engine
