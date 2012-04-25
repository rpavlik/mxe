# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# libxcb
PKG             := libxcb
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.7-withgit
$(PKG)_CHECKSUM := b25a9799d71185571bad1b996a3e0ab9137dfe41
$(PKG)_SUBDIR   := $(PKG)-c2e023646298da05e212056fbc6b329e4dd9a100
$(PKG)_FILE     := $(PKG)-c2e023646298da05e212056fbc6b329e4dd9a100.tar.bz2
$(PKG)_WEBSITE  := http://www.x.org/
$(PKG)_URL      := http://cgit.freedesktop.org/xcb/libxcb/snapshot/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xcb-proto xorg-pthread-stubs libXau libXdmcp

define $(PKG)_BUILD
    # cross build
    #sed -i 's_netinet/in.h_winsock.h_' '$(1)/src/xcb_conn.c'
    cd '$(1)' && ./autogen.sh \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-build-docs --without-Xdmcp
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
