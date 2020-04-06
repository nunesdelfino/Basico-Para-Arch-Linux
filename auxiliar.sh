pacman -S nano git grub networkmanager sudo xorg-server gdm;

pacman -S gcc gnome-tweaks xdg-user-dirs base-devel;

systemctl enable gdm;
systemctl enable NetworkManager;



echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf;

echo "arch" >> /etc/hostname;

echo "127.0.0.1         localhost";
echo "::1               localhost";
echo "127.0.0.1         arch.gnd.com arch";

mkinittcpio -P;



