# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg libXext
PKG             := libXext
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.3.0
$(PKG)_CHECKSUM := 0bf3708177b9320091ebc069e905c042c31d859d
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libX11 xorg-xproto xorg-xextproto

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
