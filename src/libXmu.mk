# This file is part of MXE.
# See index.html for further information.

PKG             := libXmu
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 81876a0848070bfc4476a2538fc16898eb6d96cd
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://www.x.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc xorg-util-macros libX11 libXt libXext

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure         --host='$(TARGET)'         --disable-shared         --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
