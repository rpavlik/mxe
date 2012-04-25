# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg libxkbfile
PKG             := libxkbfile
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.7
$(PKG)_CHECKSUM := 0fed539ffbc05859bc666b425fafa42e046bef5f
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
