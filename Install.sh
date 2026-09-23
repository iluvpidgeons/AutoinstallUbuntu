#!/bin/bash
# script made for ubuntu 26.04.1 on harmony laptops
# this script does not configure the network

echo "Updating & Upgrading System"
sleep 1
sudo apt update -y && sudo apt upgrade -y && sudo snap refresh

echo
echo "Installing Utilities"
sleep 1
sudo apt install -y \
    curl \
    git \
    smartmontools \
    glmark2

echo
echo "Installing Apps"
sleep 1
sudo apt install -y \
    audacity \
    vlc \
    gimp

echo
echo "Installing Soundshow & Canva"
sleep 1
sudo wget -P /tmp https://github.com/soundshow-app/soundshow-downloads/releases/download/v2026.05.06/SoundShow-linux-x64.zip
sudo unzip /tmp/SoundShow-linux-x64.zip -d /opt
sudo chmod +x /opt/SoundShow/SoundShow.x86_64
sudo wget -P /usr/share/icons/ https://images.seeklogo.com/logo-png/65/1/canva-logo-png_seeklogo-653227.png
sudo wget -P /usr/share/icons/ https://raw.githubusercontent.com/iluvpidgeons/AutoinstallUbuntu/refs/heads/main/SoundShow.png

CanvaDesktopFile="/usr/share/applications/canva.desktop"
SoundShowDesktopFile="/usr/share/applications/soundshow.desktop"
CanvaLogo="/usr/share/icons/canva-logo-png_seeklogo-653227.png"
SoundShowLogo="/usr/share/icons/SoundShow.png"
SoundShowExec="/opt/SoundShow/SoundShow.x86_64"

cat > "$CanvaDesktopFile" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Canva
Comment=Open Canva in Firefox
Exec=firefox --new-window https://www.canva.com/
Icon=$CanvaLogo
Terminal=false
Categories=Office;
EOF

cat > "$SoundShowDesktopFile" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=SoundShow
Comment=Open SoundShow
Exec=$SoundShowExec
Icon=$SoundShowLogo
Terminal=false
Categories=Audio;
EOF

chmod +x $CanvaDesktopFile
chmod +x $SoundShowDesktopFile

gsettings set org.gnome.shell favorite-apps \
"[
  'firefox_firefox.desktop',
  'org.gnome.Nautilus.desktop',
  'org.gnome.Ptyxis.desktop',
  'gimp.desktop',
  'audacity.desktop',
  'soundshow.desktop',
  'canva.desktop'
]"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface clock-format '12h'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

# read -r -p "Failed to download Davinci Resolve, would you like to open their website? [y/N]: " answer
# case "$answer" in
#     [yY]|[yY][eE][sS])
#         echo "Opening"
#         firefox --new-window https://www.blackmagicdesign.com/products/davinciresolve
#         ;;
#     *)
#         echo "Exiting"
#         exit 1
#         ;;
# esac

echo
echo "Davinci Resolve needs to be installed manually at https://www.blackmagicdesign.com/products/davinciresolve"
echo "It is also recommended to install Ublock Origin on Firefox at https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/"