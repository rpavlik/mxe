# This file is part of MXE.
# See index.html for further information.

PKG             := libXpm
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 38258a1d589d3f157e0338d0fd13eec11bc4a39b
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libX11 xorg-xproto libXt libXext

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)' CFLAGS='-DNO_ZPIPE' LIBS='-lpthread -lws2_32'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
