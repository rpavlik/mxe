# This file is part of MXE.
# See index.html for further information.

PKG             := xkeyboard-config
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 80f241325fed23278730a8cb565aa6c0e094b912
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/archive/individual/data/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros

define $(PKG)_UPDATE
    wget -q -O- 'http://cgit.freedesktop.org/$(PKG)/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=[^0-9]*\\([0-9][^']*\\)'.*,\\1,p" | \
    head -1
endef

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
