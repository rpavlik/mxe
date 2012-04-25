# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xkeyboard-config
PKG             := xkeyboard-config
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4
$(PKG)_CHECKSUM := 1ddffae9af937a40d6da8a943c5f44abead8cfa0
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.freedesktop.org/wiki/Software/XKeyboardConfig
$(PKG)_URL      := http://www.x.org/releases/individual/data/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-runtime-deps \
        --with-xkb-rules-symlink=xorg,xfree86
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
