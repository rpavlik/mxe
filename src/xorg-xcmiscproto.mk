# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# xorg xcmiscproto
PKG             := xorg-xcmiscproto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.1
$(PKG)_CHECKSUM := ff7ddb6e5698bf4461a524ca30f3b32e2a9dce8a
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
