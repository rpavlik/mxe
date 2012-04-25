# This file is part of MXE.
# See index.html for further information.

PKG             := libxcb
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 98199b6054750a06cddd4e77baa4354af547ce6f
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://xcb.freedesktop.org/dist/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xcb-proto xorg-pthread-stubs libXau libXdmcp

define $(PKG)_BUILD
    # cross build
    #sed -i 's_netinet/in.h_winsock.h_' '$(1)/src/xcb_conn.c'
    cd '$(1)' && ./autogen.sh \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-build-docs \
        --disable-shm
        
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
