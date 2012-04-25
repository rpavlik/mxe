# This file is part of MXE.
# See index.html for further information.

PKG             := xorg-pthread-stubs
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 7fc486ad0ec54938f8b781cc374218f50eac8b99
$(PKG)_SUBDIR   := lib$(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := lib$(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/xcb/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros pthreads

define $(PKG)_UPDATE
    wget -q -O- 'http://cgit.freedesktop.org/xcb/$(patsubst xorg-%,%,$(PKG))/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=[^0-9]*\\([0-9][^']*\\)'.*,\\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        LIBS='-lpthread'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
