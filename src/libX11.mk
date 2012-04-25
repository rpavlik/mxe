# This file is part of MXE.
# See index.html for further information.

PKG             := libX11
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 2d9d38bfd7003ec60eea0b1999ab72cfd5fa3b90
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc libxcb xtrans xorg-xproto xorg-xextproto xorg-kbproto xorg-inputproto

define $(PKG)_BUILD
    # wine confuses the cross-compiling detection, so set it explicitly
    #$(SED) -i 's,cross_compiling=no,cross_compiling=yes,' '$(1)/configure'
    $(SED) -i 's,makekeys ,makekeys$$(EXEEXT) ,' $(1)/src/Makefile.am
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
