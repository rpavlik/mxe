# This file is part of MXE.
# See index.html for further information.

PKG             := libX11
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := af10b064c1c64ee9e7daae0a7f1f9719eb7e965a
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc libxcb xtrans xorg-xproto xorg-xextproto xorg-kbproto xorg-inputproto

define $(PKG)_UPDATE
    wget -q -O- 'http://cgit.freedesktop.org/xorg/lib/$(PKG)/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=[^-']*11[^0-9]*\\([0-9][^']*\\)'.*,\\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    # wine confuses the cross-compiling detection, so set it explicitly
    #$(SED) -i 's,cross_compiling=no,cross_compiling=yes,' '$(1)/configure'
    #$(SED) -i 's,makekeys ,makekeys$$(EXEEXT) ,' $(1)/src/Makefile.am
    # cross build
    cd '$(1)' && automake && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-loadable-xcursor \
        CFLAGS='-DXFree86Server'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
