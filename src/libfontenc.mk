# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg libfontenc
PKG             := libfontenc
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.0
$(PKG)_CHECKSUM := ba158e4c10a1aff2351ef632def03dec0e0ee11e
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
