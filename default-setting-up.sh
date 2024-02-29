#!/bin/sh

set -xe

# Default things
sudo dnf update -y
sudo dnf remove -y gnome-abrt gnome-boxes gnome-characters gnome-connections gnome-contacts gnome-font-viewer gnome-logs gnome-maps gnome-system-monitor gnome-text-editor gnome-tour gnome-weather cheese rhythmbox simple-scan totem mediawriter libreoffice-calc libreoffice-writer libreoffice-impress yelp firefox
sudo dnf install -y vim git
hostnamectl set-hostname X1Z53
rm -rf ~/Music/ ~/Public/ ~/Desktop/ ~/Templates/
rm -rf ~/Музыка/ ~/Общие/ ~/Рабочий\ стол/ ~/Шаблоны/
sudo rm /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo /etc/yum.repos.d/google-chrome.repo /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo /etc/yum.repos.d/rpmfusion-nonfree-steam.repo /etc/yum.repos.d/fedora-cisco-openh264.repo /etc/yum.repos.d/repo.yandex.ru_yandex-browser_rpm_beta_x86_64.repo
flatpak remote-delete fedora
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --enable flathub

# Install FiraCode Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip FiraCode.zip ttf
mkdir -p ~/.local/share/fonts
mv ttf/*ttf ~/.local/share/fonts/
fc-cache -f -v
rm -rf ttf FiraCode.zip

# GNOME settings
sudo dnf install -y gnome-themes-extra # gnome-tweaks
gsettings set org.gnome.desktop.input-sources xkb-options "['']"
gsettings set org.gnome.desktop.interface document-font-name 'FiraCode Nerd Font Regular 10'
gsettings set org.gnome.desktop.interface font-name 'FiraCode Nerd Font Regular 10'
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font Regular 10'
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'FiraCode Nerd Font Regular 10'
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter dynamic-workspaces false

# Reinstall apps
sudo dnf remove -y baobab gnome-terminal evince gnome-clocks loupe
sudo dnf install -y qterminal
flatpak install -y flathub org.gnome.baobab md.obsidian.Obsidian io.github.tdesktop_x64.TDesktop org.libreoffice.LibreOffice org.kde.krita org.kde.kdenlive com.github.tchx84.Flatseal com.mattjakeman.ExtensionManager io.missioncenter.MissionCenter io.github.Rirusha.Cassette org.gnome.Evince org.gnome.clocks org.gnome.Loupe

# Git settings
git config --global user.name "x1z53"
git config --global user.email "x1z53@yandex.ru"
git config --global credential.helper store

# Install Yandex Browser
sudo rpmkeys --import https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG
sudo dnf config-manager --add-repo http://repo.yandex.ru/yandex-browser/rpm/beta/x86_64
sudo dnf install -y yandex-browser-beta
sudo /opt/yandex/browser-beta/update_codecs /opt/yandex/browser-beta

# Install AstroNvim
sudo dnf install -y neovim
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# Install ZSH
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
