From alpine:latest

# RUN apk add --update \
#   git \
#   nodejs \
#   npm \
#   curl \
#   make \
#   cmake \
#   build-base\
#   libtool \
#   automake \
#   && rm -rf /var/cache/apk/*

RUN apk add --update \
  git \
  alpine-sdk build-base\
  libtool \
  automake \
  m4 \
  autoconf \
  linux-headers \
  unzip \
  ncurses ncurses-dev ncurses-libs ncurses-terminfo \
  clang \
  nodejs \
  xz \
  curl \
  make \
  cmake \
  && rm -rf /var/cache/apk/*

# RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
#   chmod u+x nvim.appimage && \
  # ./nvim.appimage --appimage-extract && \
  # ./squashfs-root/AppRun --version && \
  # mv squashfs-root / && \
  # ln -s /squashfs-root/AppRun /usr/bin/nvim


RUN git clone https://github.com/neovim/neovim.git && \
  cd neovim && \
  make distclean && \
  make && \
  make install && \
  cd ../ && rm -rf nvim

RUN git clone https://github.com/PiyushDuggal-source/neovim.git ~/.config/nvim && \
  cd ~/.config/nvim && git fetch && git checkout stable && \
  npm install -g neovim
