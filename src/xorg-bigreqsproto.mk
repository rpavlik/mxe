# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg bigreqsproto
PKG             := xorg-bigreqsproto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.1
$(PKG)_CHECKSUM := 2db1d1e98958eee4d6cae0f68dbd03b2ec1018ce
$(PKG)_SUBDIR   := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/proto/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
