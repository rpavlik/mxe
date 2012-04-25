# This file is part of MXE.
# See index.html for further information.

PKG             := xorg-server
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 922b963901f4711449b53fb32ce3e14f5b642766
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/xserver/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libXaw libXfont xtrans libXau libXdmcp pixman libgcrypt xorg-xcmiscproto xorg-renderproto xorg-scrnsaverproto xorg-resourceproto xorg-xineramaproto libxkbfile

define $(PKG)_UPDATE
    wget -q -O- 'http://cgit.freedesktop.org/xorg/xserver/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=[^0-9]*\\([0-9][^']*\\)'.*,\\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-dmx \
        --disable-kdrive \
        --disable-xephyr \
        --disable-xfake \
        --disable-xfbdev \
        --disable-xorg \
        --disable-xnest \
        --disable-xvfb \
        --enable-xwin \
        --disable-config-hal \
        --disable-config-udev \
        --disable-dri \
        --disable-dri2 \
        --disable-install-setuid \
        --enable-windowswm \
        --disable-xf86bigfont \
        --disable-xf86vidmode \
        --disable-xv \
        --disable-xvmc \
        --disable-glx-tls \
        --disable-unit-tests \
        --with-sha1=libgcrypt \
        --disable-aiglx \
        --disable-glx \
        --disable-mitshm \
        LIBS='-lgpg-error -lpthread -lkernel32'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
