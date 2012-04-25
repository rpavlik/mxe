# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# libxcb
PKG             := xcb-proto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6+git
$(PKG)_CHECKSUM := 5a2d17d9f88831bf5a28bb558bd3af05cc65fc09
$(PKG)_SUBDIR   := proto-f3ae971edce37ad96ef0b8a6059c1f853e88fcf3
#$(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := proto-f3ae971edce37ad96ef0b8a6059c1f853e88fcf3.tar.bz2
#$(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://cgit.freedesktop.org/xcb/proto/snapshot/$($(PKG)_FILE)
#http://www.x.org/releases/individual/xcb/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./autogen.sh \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
