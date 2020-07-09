#
# luaposix
#
LUAPOSIX_VER    = 31
LUAPOSIX_DIR    = luaposix-$(LUAPOSIX_VER)
LUAPOSIX_SOURCE = luaposix-$(LUAPOSIX_VER).tar.gz
LUAPOSIX_SITE   = $(call github,luaposix,luaposix,v$(LUAPOSIX_VER))

LUAPOSIX_PATCH   = \
	0001-fix-docdir-build.patch

$(D)/luaposix: bootstrap host-lua lua luaexpat slingshot gnulib
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		tar -C gnulib --strip=1 -xf $(DL_DIR)/$(GNULIB_SOURCE); \
		tar -C slingshot --strip=1 -xf $(DL_DIR)/$(SLINGSHOT_SOURCE); \
		$(call apply_patches, $(PKG_PATCH)); \
		export LUA=$(HOST_LUA_BINARY); \
		./bootstrap $(SILENT_OPT); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--exec-prefix=/usr \
			--libdir=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVER) \
			--datarootdir=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER) \
			--mandir=$(TARGET_DIR)/.remove \
			--docdir=$(TARGET_DIR)/.remove \
			--enable-silent-rules \
			; \
		$(MAKE); \
		$(MAKE) install
	$(PKG_REMOVE)
	$(TOUCH)
