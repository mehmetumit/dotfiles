#!/bin/sh

set -e
cd ~
echo 'Bootstrapping fedora...'
#
# printf 'fastestmirror=True\nmax_parallel_downloads=5\nkeepcache=True' >> /etc/dnf/dnf.conf
#
# add this to disable password typing with sudo by typing sudo visudo -> your_username ALL=(ALL) NOPASSWD: ALL
#
# Edit grub -> /etc/default/grub -> then run "sudo update-grub"
# GRUB_CMDLINE_LINUX="quiet" -> remove quiet here
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3" -> add this
# GRUB_CMDLINE_LINUX_DEFAULT="acpi_enforce_resources=lax" -> add this if lm-sensors won't show fan usage
# GRUB_TERMINAL_OUTPUT="console" -> remove this to disable graphical boot
# GRUB_CMDLINE_LINUX="rhgb" -> remove this
# GRUB_CMDLINE_LINUX="verbose" -> might be useful to add this
#
# Run this to update grub afterward -> grub2-mkconfig -o "$(readlink -e /etc/grub2.cfg)"
#
# Install fonts to /usr/share/fonts
#
# Run resolvectl dns [interface-name] [dns-server1] [dns-server2] command to set custom dns

sudo hostnamectl set-hostname fedora

sudo dnf -y update
sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing
sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf -y groupupdate sound-and-video
sudo dnf -y install intel-media-driver
# To lock version of some packages
sudo dnf install 'dnf-command(versionlock)'
#sudo dnf install nvidia-vaapi-driver

# Disable unnecessary services
sudo systemctl disable NetworkManager-wait-online.service

# enable copr repos
sudo dnf copr -y enable mamg22/nsxiv
sudo dnf copr -y enable skidnik/clipmenu
sudo dnf copr -y enable zeno/scrcpy
sudo dnf copr -y enable trixieua/nbfc-linux
sudo dnf copr -y enable luminoso/k9s
sudo dnf copr -y enable atim/lazygit
sudo dnf copr -y enable coder966/postman
sudo dnf copr -y enable wezfurlong/wezterm-nightly
# import custom packages
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:justkidding/Fedora_39/home:justkidding.repo

# dnf installations
sudo dnf -y install \
@development-tools \
@base-x \
@x-software-development \
libXinerama-devel \
dnf-plugins-core \
git \
tmux \
openfortivpn \
gvim \
neovim \
zsh \
zsh-autosuggestions \
zsh-syntax-highlighting \
make \
docker \
docker-compose \
docker-buildx-plugin \
kubernetes \
stow \
ranger \
syncthing \
gcc \
g++ \
neofetch \
vlc \
yt-dlp \
pip \
nitrogen \
zathura \
zathura-djvu \
zathura-pdf-mupdf \
gh \
nsxiv \
ntfs-3g \
chromium \
qbittorrent \
obs-studio \
discord \
libreoffice \
chafa \
gimp \
java-latest-openjdk \
openvpn \
alacritty \
cmake \
playerctl \
scrot \
shellcheck \
screenkey \
mpv \
android-tools \
clipmenu \
scrcpy \
p7zip \
qrencode \
httrack \
cmus \
gthumb \
nmap \
figlet \
dunst \
tk \
tor \
net-tools \
netcat \
ffmpegthumbnailer \
nodejs \
npm \
mediainfo \
fzf \
gparted \
yarnpkg \
btop \
maven \
sassc \
irssi \
mutt \
aria2 \
freerdp \
ncdu \
easyeffects \
pandoc \
nbfc-linux \
texlive \
biber \
bat \
ripgrep \
rofi \
rofimoji \
stress \
tree \
patch \
newsboat \
pdftk \
gromit-mpx \
python3-subliminal \
slop \
entr \
rust \
cargo \
rust-analyzer \
masscan \
dnsmasq \
qemu \
virt-manager \
libvirt \
light \
helm \
awscli2 \
go \
xss-lock \
xautolock \
xev \
picom \
tlp \
xset \
k9s \
python3.9 \
rxvt-unicode \
htop \
lazygit \
google-noto-color-emoji-fonts \
gnome-tweaks \
lm_sensors \
distrobox \
openssl \
brave-browser \
keepassxc \
postman \
ueberzugpp \
pinta \
task \
vit \
flameshot \
git-delta \
earlyoom \
thunar \
imhex \
python3-virtualenv \
binwalk \
qalculate \
qalculate-qt

# pip installations
pip install pulsemixer
pip install python3-xlib
pip install iredis
#pip install ueberzug

# flatpak installations
flatpak -y install zaproxy
flatpak -y install anki
flatpak -y install com.stremio.Stremio
flatpak -y install flathub org.localsend.localsend_app
flatpak -y install com.mongodb.Compass

# go installations
go install github.com/rakyll/hey@latest
go install github.com/gokcehan/lf@latest
go install github.com/mehmetumit/dive@latest
go install github.com/jesseduffield/lazydocker@latest

# install custom packages
# dragon
git clone https://github.com/mwh/dragon.git
cd dragon
sudo dnf -y install gtk3-devel
sudo make DESTDIR='/usr' PREFIX='' NAME='dragon-drag-and-drop' install
cd .. && rm -rf dragon
# vimv
git clone https://github.com/thameera/vimv.git
cd vimv
sudo PREFIX='/usr' make install
cd .. && rm -rf vimv
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf -y install code


# install dotfiles
cd ~
git clone https://github.com/mehmetumit/dotfiles
cd dotfiles
git submodule update --init --recursive
stow --adopt */
cd ~
# fix wifi connection error on rtw_8821ce
sudo cp ./scripts/.scripts/config/rtw88_pci.conf /etc/modprobe.d/
# setup k380-swap-keys
cd ./scripts/.scripts/k380-swap-keys/
sudo make install
cd ~
# setup dwm
cd ./scripts/.scripts/ && comp-dwm && cd ~
# setup dive
cd ~
git clone https://github.com/mehmetumit/dive.git
cd dive && go install . && rm -rf dive/ && cd ~

# install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Run :PlugInstall inside of vim"


# necessary operations
sudo mkdir -p /etc/X11/xorg.conf.d
sudo cp -rf ~/dotfiles/X11/xorg.conf.d/. /etc/X11/xorg.conf.d/

sudo ln -s /usr/bin/nsxiv /usr/bin/sxiv

sudo usermod -aG libvirt "$(whoami)"
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo virsh net-autostart default

sudo ln -s ~/.scripts/ /root/.scripts

sudo ln -s /bin/7za /bin/7z

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker # load group changes without log out

mkdir -p ~/distrobox/arch ~/distrobox/ubuntu
distrobox-create -i archlinux:latest -n arch -H ~/distrobox/arch/
distrobox-create -i ubuntu:latest -n ubuntu -H ~/distrobox/ubuntu/

# Edit here for configuration /etc/default/earlyoom
sudo systemctl enable --now earlyoom

## increase file descriptor limit
# sudo printf "$USER\tsoft\tnofile\t4096\nroot\tsoft\tnofile\t4096" | sudo tee -a /etc/security/limits.conf

# printf '#!/bin/sh\nflatpak run com.brave.Browser' | sudo tee /bin/brave && sudo chmod +x /bin/brave
# Generate certs to .config/Postman/proxy/certificates/
openssl req -subj '/C=US/CN=Postman Proxy' -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyout ~/.config/Postman/proxy/certificates/postman-proxy-ca.key -out ~/.config/Postman/proxy/certificates/postman-proxy-ca.crt
# change default shell
chsh -s /usr/bin/zsh
# TODO install fonts
# init icons
sudo cp -r ~/dotfiles/icons/.icons/* /usr/share/icons/

#sudo pacman -S minikube
#sudo pacman -S skaffold
#sudo pacman -S dust
# ADR documentation generator
#yay -S adr-tools
