#!/bin/sh

# Store away where we have copied the git directory
gitdir="$(pwd)"

# Go to home and make a config dir
cd 
mkdir -p .config/nvim
cd .config/nvim
# Copy the neovim config
cp $gitdir/init.lua .

# Download and install neovim 
cd 
git clone https://github.com/neovim/neovim
cd neovim 
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Download and install ccls
cd 
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cmake -S. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/path/to/clang+llvm-xxx
cmake --build Release
cd Release 
sudo make install 
