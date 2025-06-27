#!/bin/sh

# Store away where we have copied the git directory
gitdir="$(pwd)"

# Go to home and make a config dir
cd 
mkdir -p .config/nvim
cd .config/nvim
# Copy the neovim config
cp $gitdir/init.lua .

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

# Download and install rust-analyzer
cd
mkdir rust_anl 
cd rust_anl 
wget https://github.com/rust-lang/rust-analyzer/releases/download/2025-06-09/rust-analyzer-x86_64-unknown-linux-gnu.gz
gzip -d rust-analyzer-x86_64-unknown-linux-gnu.gz
chmod +x rust-analyzer-x86_64-unknown-linux-gnu
mv rust-analyzer-x86_64-unknown-linux-gnu rust-analyzer
export PATH="$(pwd):$PATH"

# install pyright
pip install --break-system-packages pyright

cd
nvim --headless --listen 0.0.0.0:8888
