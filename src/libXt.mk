# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg libXt
PKG             := libXt
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.1
$(PKG)_CHECKSUM := a29a97f8521bdc7a95364e163f0ce474de572ae5
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libSM libX11 xorg-xproto

define $(PKG)_BUILD
    # cross build
    $(SED) -i 's,makestrs ,makestrs$$(EXEEXT) ,' '$(1)/src/Makefile.am'
    cd '$(1)' && automake && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
