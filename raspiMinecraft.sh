sudo apt-get update
sudo apt install curl libx11-6 libxext6 libegl1-mesa zlib1g libstdc++6 libgl1-mesa-dri libasound2 libpulse0 libcom-err2 libgmp10 libp11-kit0
curl -L https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/appimage/Minecraft_Bedrock_Launcher-armhf.0.0.540.AppImage --output MC.AppImage
chmod +x MC.AppImage
./MC.AppImage


 #sudo apt-get install zlib1g-dev libncurses5-dev libgles2-mesa-dev zlib1g-dev libx11-dev linux-libc-dev uuid-dev libpng-dev libxext6

 #cd ~/Downloads
 #wget https://cmake.org/files/v3.7/cmake-3.7.1.tar.gz
 #tar -xzf cmake-3.7.1.tar.gz
 #cd cmake-3.7.1
 #./bootstrap
 #sudo make package install

 #cd ~/Downloads
 #git clone https://github.com/marinaluna/mcpelauncher-pi.git
 #cd mcpelaunher-pit
 #cmake .
 #make

 ##downloader tool
 #sudo apt-get install cmake zlib1g-dev libcurl4-openssl-dev protobuf-compiler

 #cd ~/Downloads
 #git clone https://github.com/MCMrARM/Google-Play-API.git
 #cd Google-Play-API
 #mkdir build && cd build
 #cmake ..
 #make
