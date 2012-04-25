# This file is part of MXE.
# See index.html for further information.

PKG             := libXpm
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := eca9dbfa6253f7d6cc7d593dc83110c6c4876d7c
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libX11 xorg-xproto libXt libXext

define $(PKG)_UPDATE
    wget -q -O- 'http://cgit.freedesktop.org/xorg/lib/$(PKG)/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=[^0-9]*\\([0-9][^']*\\)'.*,\\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)' CFLAGS='-DNO_ZPIPE' LIBS='-lpthread -lws2_32'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
