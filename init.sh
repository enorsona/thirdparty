#!/bin/bash

#
# variables
#

readonly root_password="root!pass2025"
readonly user_password="AA2025pass!bamboo"
readonly user_name="aria"
readonly user_ssh_path="/home/$user_name/.ssh"
readonly ssh_key_download_path=".temp/authorized_keys"
readonly sshd_config="/etc/ssh/sshd_config"

#
# set root password
#

echo -e "$root_password\n$root_password" | passwd root

#
# create user
#

useradd -m "$user_name"
echo -e "$user_password\n$user_password" | passwd "$user_name"
echo -e "$user_name ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
cp -r /root/.oh-my-zsh "/home/$user_name"
wget -q -O "/home/$user_name/.zshrc" "https://cdn.jsdelivr.net/gh/enorsona/thirdparty@master/.zshrc"

# ssh public key
mkdir .temp
wget -q -O "$ssh_key_download_path" "https://cdn.jsdelivr.net/gh/enorsona/thirdparty@master/authorized_keys"

if [[ -f "$ssh_key_download_path" ]]; then
        if [[ -d "/root/.ssh" ]]; then
                cp .temp/authorized_keys /root/.ssh/
                chmod 600 /root/.ssh/authorized_keys
        fi

        mkdir "$user_ssh_path"
        cp "$ssh_key_download_path" "$user_ssh_path"
        chown "$user_name:$user_name" -R "$user_ssh_path"
        chmod 700 "$user_ssh_path"
        chmod 600 "$user_ssh_path/authorized_keys"

fi

# 确保文件存在
if [[ -f "$sshd_config" ]]; then
    # 禁止 root 登录
    sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' "$sshd_config"
    sed -i '/^PermitRootLogin/!s/^#PermitRootLogin.*/PermitRootLogin no/' "$sshd_config"

    # 禁止密码登录
    sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' "$sshd_config"
    sed -i '/^PasswordAuthentication/!s/^#PasswordAuthentication.*/PasswordAuthentication no/' "$sshd_config"

    # 仅允许 ed25519 密钥
    sed -i 's/^#PubkeyAcceptedKeyTypes.*/PubkeyAcceptedKeyTypes ssh-ed25519/' "$sshd_config"
    sed -i '/^PubkeyAcceptedKeyTypes/!s/^#PubkeyAcceptedKeyTypes.*/PubkeyAcceptedKeyTypes ssh-ed25519/' "$sshd_config"

fi

systemctl enable sshd
