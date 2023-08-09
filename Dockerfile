FROM archlinux/archlinux:latest

EXPOSE 35901

RUN pacman -Suy --noconfirm

RUN pacman -S git emacs tar ripgrep fd vim --noconfirm

RUN git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d

RUN mkdir /files

