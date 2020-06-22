#
# libmnl
#
LIBMNL_VER    = 1.0.4
LIBMNL_DIR    = libmnl-$(LIBMNL_VER)
LIBMNL_SOURCE = libmnl-$(LIBMNL_VER).tar.bz2
LIBMNL_SITE   = http://netfilter.org/projects/libmnl/files

$(D)/libmnl: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
