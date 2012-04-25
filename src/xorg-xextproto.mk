# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg xproto
PKG             := xorg-xextproto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 7.2.0
$(PKG)_CHECKSUM := a117fb9d7fdebee7af3f9e79efe9812e39e650a5
$(PKG)_SUBDIR   := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/proto/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
