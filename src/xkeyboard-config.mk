# This file is part of MXE.
# See index.html for further information.

PKG             := xkeyboard-config
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 1ddffae9af937a40d6da8a943c5f44abead8cfa0
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
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
