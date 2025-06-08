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
# cd 
# git clone https://github.com/neovim/neovim
# cd neovim 
# make CMAKE_BUILD_TYPE=RelWithDebInfo
# sudo make install

cd
mkdir nvim 
cd nvim 
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
tar -xf nvim-linux-x86_64.tar.gz
cd nvim-linux-x86_64/bin
export PATH="$(pwd):$PATH"

# Download and install clangd
cd
mkdir clangd
cd clangd
wget https://github.com/clangd/clangd/releases/download/19.1.2/clangd-linux-19.1.2.zip
python3 -m zipfile -e clangd-linux-19.1.2.zip . # This is really the only way
cd clangd_19.1.2/bin
chmod +x clangd
export PATH="$(pwd):$PATH"


# cd 
# git clone --depth=1 --recursive https://github.com/MaskRay/ccls
# cd ccls
# cmake -S. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/path/to/clang+llvm-xxx
# cmake --build Release
# cd Release 
# sudo make install 
