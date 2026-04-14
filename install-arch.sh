#! /bin/bash

# Install Arch Linux dependencies
echo "Installing dependencies for Arch Linux..."
sudo pacman -S libuv openssl zlib base-devel cmake eigen

# Build and install uWebSockets
git clone https://github.com/uWebSockets/uWebSockets 
cd uWebSockets
git checkout e94b6e1
mkdir build
cd build
cmake ..
make 
sudo make install
cd ..
cd ..

# Create symlink for library if needed
if [ -f /usr/lib64/libuWS.so ] && [ ! -f /usr/lib/libuWS.so ]; then
    sudo ln -s /usr/lib64/libuWS.so /usr/lib/libuWS.so
fi

sudo rm -r uWebSockets

echo "Installation complete!"
