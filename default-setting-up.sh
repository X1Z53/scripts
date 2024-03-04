#!/bin/sh

set -xe

# Usual stuff
sudo dnf remove -y gnome-abrt gnome-boxes gnome-characters gnome-connections gnome-contacts gnome-font-viewer gnome-logs gnome-maps gnome-system-monitor gnome-text-editor gnome-tour cheese rhythmbox simple-scan totem mediawriter libreoffice-calc libreoffice-writer libreoffice-impress yelp firefox nano
sudo dnf install -y vim git
hostnamectl set-hostname X1Z53
rm -rf ~/Music/ ~/Public/ ~/Desktop/ ~/Templates/
rm -rf ~/Музыка/ ~/Общие/ ~/Рабочий\ стол/ ~/Шаблоны/

# Repositories
sudo rm -r /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo /etc/yum.repos.d/google-chrome.repo /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo /etc/yum.repos.d/rpmfusion-nonfree-steam.repo /etc/yum.repos.d/fedora-cisco-openh264.repo
sudo flatpak remote-delete fedora
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --enable flathub

# FiraCode Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip FiraCode.zip -d ttf
mkdir -p ~/.local/share/fonts
mv ttf/*ttf ~/.local/share/fonts/
fc-cache -f -v
rm -rf ttf FiraCode.zip

# Gsettings
sudo dnf install -y gnome-themes-extra
gsettings set org.gnome.desktop.input-sources xkb-options "['']"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface document-font-name "FiraCode Nerd Font Regular 10"
gsettings set org.gnome.desktop.interface font-name "FiraCode Nerd Font Regular 10"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface monospace-font-name "FiraCode Nerd Font Regular 10"
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
gsettings set org.gnome.desktop.wm.preferences titlebar-font "FiraCode Nerd Font Regular 10"
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter dynamic-workspaces false

# Flatpak
sudo dnf remove -y baobab gnome-terminal evince gnome-clocks loupe gnome-weather 
sudo dnf install -y qterminal
flatpak install -y flathub org.gnome.baobab md.obsidian.Obsidian io.github.tdesktop_x64.TDesktop org.libreoffice.LibreOffice org.kde.krita org.kde.kdenlive com.github.tchx84.Flatseal com.mattjakeman.ExtensionManager io.missioncenter.MissionCenter io.github.Rirusha.Cassette org.gnome.Evince org.gnome.clocks org.gnome.Loupe org.gnome.Weather

# Git
git config --global core.editor "nvim"
git config --global user.name "x1z53"
git config --global user.email "x1z53@yandex.ru"
git config --global credential.helper store

# Yandex Browser
sudo rpmkeys --import https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG
sudo dnf config-manager --add-repo http://repo.yandex.ru/yandex-browser/rpm/beta/x86_64
sudo dnf install -y yandex-browser-beta
sudo /opt/yandex/browser-beta/update_codecs /opt/yandex/browser-beta
rm ~/yandex-browser-beta.desktop

# AstroNvim
sudo dnf install -y neovim gcc
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# QTerminal
sed -i "s/HideTabBarWithOneTab=false/ideTabBarWithOneTab=true/g"         ~/.config/qterminal.org/qterminal.ini
sed -i "s/HistoryLimited=true/istoryLimited=false/g"                     ~/.config/qterminal.org/qterminal.ini
sed -i "s/MenuVisible=true/enuVisible=false/g"                           ~/.config/qterminal.org/qterminal.ini
sed -i "s/ScrollbarPosition=2/crollbarPosition=0/g"                      ~/.config/qterminal.org/qterminal.ini
sed -i "s/highlightCurrentTerminal=true/ighlightCurrentTerminal=false/g" ~/.config/qterminal.org/qterminal.ini
sed -i "s/fontFamily=Monospace/fontFamily=FiraCode Nerd Font/g"          ~/.config/qterminal.org/qterminal.ini

# Install ZSH
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
