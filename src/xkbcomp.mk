# This file is part of MXE.
# See index.html for further information.

PKG             := xkbcomp
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 695d2f2824884d9e54aa1419282ae167fdea163b
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/app/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc pthreads libX11 libxkbfile

define $(PKG)_UPDATE
    wget -q -O- 'http://cgit.freedesktop.org/xorg/app/$(PKG)/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=[^0-9]*\\([0-9][^']*\\)'.*,\\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)' \
        LIBS='-lws2_32 -lpthread'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
