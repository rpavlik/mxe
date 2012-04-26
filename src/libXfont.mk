# This file is part of MXE.
# See index.html for further information.

PKG             := libXfont
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 0bf3cb8aa192ab96bbaf384d1a4a00d15a40171e
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libX11 xorg-xproto xtrans xorg-fontsproto libfontenc freetype

define $(PKG)_UPDATE
    wget -q -O- 'http://cgit.freedesktop.org/xorg/lib/$(PKG)/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=[^0-9]*\\([0-9][^']*\\)'.*,\\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
