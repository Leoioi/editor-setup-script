#!/bin/sh

# Store away where we have copied the git directory
gitdir="$(pwd)"

# Go to home and make a config dir
cd 
mkdir -p .config/nvim
# Copy the neovim config
cp $gitdir/init.lua .

# Download and install neovim 
cd 
git clone https://github.com/neovim/neovim
cd neovim 
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install


