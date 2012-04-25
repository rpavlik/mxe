# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# MinGW catgets implementation
PKG             := mingw-catgets
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.1
$(PKG)_CHECKSUM := c39ef09f87c76253d01e200813167aef0bad004b
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION)-src.tar.gz
$(PKG)_WEBSITE  := http://www.mingw.org/
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/mingw/MinGW/catgets/$(PKG)-$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     :=

define $(PKG)_UPDATE
    wget -q -O- 'http://sourceforge.net/projects/mingw/files/MinGW/BaseSystem/RuntimeLibrary/catgets/' | \
    $(SED) -n 's,.*mingw-catgets-\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    # cross build
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
