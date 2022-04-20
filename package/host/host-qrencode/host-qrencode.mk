#
# host-qrencode
#
HOST_QRENCODE_VERSION = 4.1.1
HOST_QRENCODE_DIR     = qrencode-$(HOST_QRENCODE_VERSION)
HOST_QRENCODE_SOURCE  = qrencode-$(HOST_QRENCODE_VERSION).tar.gz
HOST_QRENCODE_SITE    = https://fukuchi.org/works/qrencode
HOST_QRENCODE_DEPENDS = bootstrap

HOST_QRENCODE_CONF_OPTS = \
	LDFLAGS="-L/usr/lib/x86_64-linux-gnu -lpng" \
	png_CFLAGS="-I/usr/include/libpng"

$(D)/host-qrencode:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(HOST_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)