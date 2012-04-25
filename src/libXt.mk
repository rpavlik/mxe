# This file is part of MXE.
# See index.html for further information.

PKG             := libXt
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 2cef068bc4d7170e31b89b5c06aeaf4451a7699a
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libSM libX11 xorg-xproto

define $(PKG)_UPDATE
    wget -q -O- 'http://cgit.freedesktop.org/xorg/lib/$(PKG)/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=[^0-9]*\\([0-9][^']*\\)'.*,\\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    # cross build
    $(SED) -i 's,makestrs ,makestrs$$(EXEEXT) ,' '$(1)/src/Makefile.am'
    cd '$(1)' && automake && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
