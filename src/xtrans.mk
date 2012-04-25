# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg xtrans
PKG             := xtrans
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.6
$(PKG)_CHECKSUM := 99f019a6e6d4d2b8274c4a27f9c8482c7fc64e85
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
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
