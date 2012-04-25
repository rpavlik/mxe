# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg util-macros
PKG             := xorg-util-macros
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.15.0
$(PKG)_CHECKSUM := 1c4871ba4b4c6cac894b64489053d85e0a122e60
$(PKG)_SUBDIR   := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/util/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
