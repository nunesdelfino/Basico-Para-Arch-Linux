#!/bin/bash

# Script para instalar o ArchLinux
# O Script está focado no ambiente GNOME
# O que muda é apenas a instlação do ambiente gráfico
# 
# Autor: Gabriel Nunes Delfino
# E-Mail: ti.gabrieldelfino@gmail.com
# GitHub: nunesdelfino
#

# CONFIGURAR O TECLADO NO PADRÃO CERTO
    # Nesse caso o padrão brasil abnt2
        loadkeys br-abnt2

# HABILITAR O NTP
    timedatectl set-ntp true

# CRIAR PARTIÇÕES
    fdisk /dev/"Nome do disco"

    n - para criar uma nova partição
    p - para primaria
    +"TAMANHO DA PARTIÇÃO"G
    t - para mudar o tipo de uma partição
    82 - Codigo swap
    w - salva

# FORMATAR PARTIÇÕES
    mkfs.ext4 

# MONTAR PARTIÇÃO CORRESPONDENTE A / NA PASTA /mnt
    mount /dev/sdaX /mnt

# CRIAR DENTRO DA /mnt AS PASTAS CORRESPONDENTES AS PARTIÇÕES CRIADAS SEPARADAS
    mkdir /mnt/"NOME DA PARTIÇÃO"

# MONTAR AS PARTIÇÕES NAS PASTAS CRIADAS
    mount /dev/sdaX /mnt/"NOME DA PASTA"

# ESCOLHER A MIRROR PARA OS DOWNLOADS DENTRO DE /etc/pacman.d/mirrorlist
    nano /etc/pacman.d/mirrorlist
        
# EXECUTAR O pacstrap PARA BAIXAR OS PACOTES ESSENCIAIS PARA O SISTEMA
    pacstrap /mnt base linux linux-firmware

# CRIAR A fstab
    genfstab -U /mnt >> /mnt/etc/fstab

# FAZER O /mnt VIRAR O /
    arch-chroot /mnt

# INTALAR UM EDITOR DE TEXTO
    Pode ser o nano ou o vim
        pacman -S nano
        pacman -S vim

# SETAR TIMEZONE
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    hwclock --systohc

# SETAR A LOCALIDADE PARA OS CARACTERES
    nano /etc/locale.gen
        descomentar o pt_BR.UTF-8 UTF-8
            executar o comando locale-gen
                editar o arquivo /etc/locale.conf
                    nano /etc/locale.conf
                        LANG=pt_BR.UTF-8
                            editar o arquivo /etc/vconsole.conf
                                KEYMAP=br-abnt2

# CONFIGURAR HOSTNAME
    nano /etc/hostname

# CONFIGURAR OS HOSTS
    nano /etc/hosts
        127.0.0.1       localhost
        ::1             localhost
        127.0.0.1       arch.gnd.com    arch

# CRIAR A Initramfs
    mkinittcpio -P

# SENHA ROOT
    passwd

# INTALAR O GRUB
    pacman -S grub

# CRIAR O GRUB NO DISCO
    grub-install /dev/sda

# GERAR ARQUIVO DE CONFIGURAÇÃO DO GRUB
    grub-mkconfig -o /boot/grub/grub.cfg

# INSTALAR O GERENCIADOR DE REDE
    pacman -S networkmanager

# CONFIGURAR PARA O A REDE INICIAR NO BOOT
    systemctl enable NetworkManager

# INSTALAR O SUDO
    pacman -S sudo

# CRIAR NOVO USUÁRIO
    useradd -m "Nome do Usuário"
    passwd "Nome do Usuário"

# EDITAR O SUDOERS PARA DAR PERMIÇÕES AO USUÁRIO CRIADO
    nano /etc/sudoers

# INSTALAR O DRIVER DE VÍDEO
    pacman -S xf86-video-vesa

# INSTALAR AMBIENTE GRÁFICO
    pacman -S gnome gdm
    systemctl enable gdm