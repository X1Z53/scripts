#!/bin/bash

set -xe

# PowerLevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/plugins=(git)/plugins=( git zsh-syntax-highlighting zsh-autosuggestions )/g' ~/.zshrc

# Useful stuff (aliases)
sudo dnf install -y exa zoxide
echo "eval \"\$(zoxide init zsh)\"" >> ~/.zshrc
echo "alias cd=\"z\""               >> ~/.zshrc
echo "alias ls=\"exa\""             >> ~/.zshrc

echo ""
echo "Do it yourself:"
echo "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \$ZSH_CUSTOM/themes/powerlevel10k"

