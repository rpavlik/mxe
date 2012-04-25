# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg xkbcomp
PKG             := xkbcomp
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.3
$(PKG)_CHECKSUM := c20d1b5b8e25634cc9a79c5e4c3397a5ffbee1e0
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/app/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc pthreads libX11 libxkbfile

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)' \
        LIBS='-lws2_32 -lpthread'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
