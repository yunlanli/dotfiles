#!/bin/bash
echo "Start downloading SpaceMono Nerd Fonts zip file from GitHub..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SpaceMono.zip

echo "Unzipping font files into ~/.local/share/fonts directory..."
unzip -d ~/.local/share/fonts SpaceMono.zip

echo "Removing zip files and nerdFont directory..."
rm SpaceMono.zip
rm -rf --interactive=never nerdFont

