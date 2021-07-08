#!/bin/bash
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

# download themes
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip
# add customized theme
cp yunlan.omp.json ~/.poshthemes/

# download Nerd Fonts
./font.sh
echo "Please set your terminal to use Space Mono Nerd Font for glyphs to work correctly"

# use slimfat.omp.json theme
mytheme=yunlan
echo "Use $mytheme oh-my-posh theme..."
echo "eval \"\$(oh-my-posh --init --shell bash --config ~/.poshthemes/$mytheme.omp.json)\"" >> ~/.bashrc

echo "Activating the theme..."
. ~/.bashrc
echo "Done!"
