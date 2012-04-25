# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg libWindowsWM
PKG             := libWindowsWM
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.1
$(PKG)_CHECKSUM := 23e0fe25060c859b4c40999d264133127e6e1ca7
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libX11 libXext xorg-xextproto xorg-windowswmproto

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
