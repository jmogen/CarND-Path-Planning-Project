#! /bin/bash

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect OS"
    exit 1
fi

# Install dependencies based on distribution
case $OS in
    ubuntu|debian)
        echo "Installing for Ubuntu/Debian..."
        sudo apt-get install libuv1-dev libssl-dev libz-dev
        ;;
    arch|manjaro)
        echo "Installing for Arch Linux..."
        sudo pacman -S libuv openssl zlib base-devel cmake
        ;;
    *)
        echo "Unsupported OS: $OS"
        echo "Please install manually: libuv-dev, libssl-dev, libz-dev (or equivalent)"
        exit 1
        ;;
esac

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

# Create symlink for library if needed (mainly for older systems)
if [ -f /usr/lib64/libuWS.so ] && [ ! -f /usr/lib/libuWS.so ]; then
    sudo ln -s /usr/lib64/libuWS.so /usr/lib/libuWS.so
fi

sudo rm -r uWebSockets

echo "Installation complete!"
