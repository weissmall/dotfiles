FROM archlinux:latest AS main

WORKDIR /home/user

# Update system
RUN pacman -Suy --noconfirm

# Install ansible for automation
RUN pacman -S ansible --noconfirm
