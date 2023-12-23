#! /bin/bash

# 变量环节
Maker=$(grep "model name" /proc/cpuinfo | uniq)
Year=$(date +%Y)
PINCODE="AA${Year}pass!bamboo"
FontFolder="/usr/local/share/fonts"

# 执行脚本
# 设置时区
ln -sf /usr/share/zoneinfo/Japan /etc/localtime
hwclock --systohc
# 设置设备名
echo "Ariark Device" > "/etc/hostname"
echo "LANG=en_US.UTF-8" > "/etc/locale.conf"
# 设置语言
sed -i "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g; s/#zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g" /etc/locale.gen
locale-gen

# 同步时间
timedatectl
# 安装ucode
if [[ $Maker == *"Intel"* ]]; then
	echo "检测到Intel处理器。执行Intel Ucode安装..."
	pacman -S intel-ucode --noconfirm
if [[ $Maker == *"AMD"* ]]; then
	echo "检测到AMD处理器。执行AMD Ucode安装..."
	pacman -S amd-ucode --noconfirm
# 开始安装基础软件包
pacman -S dhcpcd iwd vim sudo unzip wget git base-devel openssh docker zsh grub efibootmgr arch-install-scripts networkmanager --noconfirm
# 创建日本镜像站点列表
wget -O /etc/pacman.d/mirrorlist https://raw.githubusercontent.com/enorsona/thirdparty/master/mirrorlist
# 安装字体
mkdir -p "$FontFolder"
chmod 555 "$FontFolder"
wget -O "$FontFolder/AriarkRound.ttf" https://github.com/enorsona/thirdparty/raw/master/AriarkRound-Regular.ttf
chmod 444 "$FontFolder/AriarkRound.ttf"
# 生成fstab
genfstab -U / >> /etc/fstab

# 准备AUR
cd /opt
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# 准备ROOT用户密码
echo -e "$PINCODE\n$PINCODE" | passwd root
yay -S systemd-numlockontty

# 准备一般用户
useradd -m syllaris
echo -e "$PINCODE\n$PINCODE" | passwd syllaris

# 准备sudoers
sed -i "/root ALL=(ALL:ALL) ALL/a syllaris ALL=(ALL:ALL) NOPASSWD:ALL"

# 设置引导服务
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Grub
grub-mkconfig -o /boot/grub/grub.cfg
