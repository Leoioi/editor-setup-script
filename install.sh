#!/bin/sh

# Store away where we have copied the git directory
gitdir="$(pwd)"

install_dir="/home/"

# Go to home and make a config dir
cd $install_dir 
mkdir -p .config/nvim
cd .config/nvim
# Copy the neovim config
cp $gitdir/init.lua .


mkdir -p ~/.config/helix
cd ~/.config/helix
cp $gitdir/config.toml .
cp $gitdir/languages.toml .

cd $install_dir 
mkdir nvim 
cd nvim 
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
tar -xf nvim-linux-x86_64.tar.gz
cd nvim-linux-x86_64/bin
# install nvim /usr/local/bin
export PATH="$(pwd):$PATH"


# Install your editor of choose ;)
cd $install_dir 
mkdir helix
cd helix
wget https://github.com/helix-editor/helix/releases/download/25.01.1/helix-25.01.1-x86_64-linux.tar.xz
tar -xf helix-25.01.1-x86_64-linux.tar.xz
cd helix-25.01.1-x86_64-linux
# install hx /usr/local/bin
export PATH="$(pwd):$PATH"


# Download and install clangd
cd $install_dir 
mkdir clangd
cd clangd
wget https://github.com/clangd/clangd/releases/download/19.1.2/clangd-linux-19.1.2.zip
python3 -m zipfile -e clangd-linux-19.1.2.zip . # This is really the only way
cd clangd_19.1.2/bin
chmod +x clangd
# install clangd /usr/local/bin
export PATH="$(pwd):$PATH"

# Download and install rust-analyzer
cd $install_dir 
mkdir rust_anl 
cd rust_anl 
wget https://github.com/rust-lang/rust-analyzer/releases/download/2025-06-09/rust-analyzer-x86_64-unknown-linux-gnu.gz
gzip -d rust-analyzer-x86_64-unknown-linux-gnu.gz
chmod +x rust-analyzer-x86_64-unknown-linux-gnu
mv rust-analyzer-x86_64-unknown-linux-gnu rust-analyzer
# install rust-analyzer /usr/local/bin
export PATH="$(pwd):$PATH"

# install pyright
pip install --break-system-packages pyright python-lsp-server


# install ruff (the better python lsp)
cd
mkdir ruff
cd ruff
wget https://github.com/astral-sh/ruff/releases/download/0.12.2/ruff-i686-unknown-linux-gnu.tar.gz
tar -xf ruff-i686-unknown-linux-gnu.tar.gz
cd ruff-i686-unknown-linux-gnu
# install ruff /usr/local/bin
export PATH="$(pwd):$PATH"


# Add to the bachrc
echo "export PATH=$PATH" >> ~/.bashrc

cd
source .bachrc
# nvim --headless --listen 0.0.0.0:8888
sleep infinity
