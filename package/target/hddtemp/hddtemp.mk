#
# hddtemp
#
HDDTEMP_VER    = 0.3-beta15
HDDTEMP_DIR    = hddtemp-$(HDDTEMP_VER)
HDDTEMP_SOURCE = hddtemp-$(HDDTEMP_VER).tar.bz2
HDDTEMP_SITE   = http://savannah.c3sl.ufpr.br/hddtemp

$(D)/hddtemp: bootstrap libiconv
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) LIBS="-liconv" \
			--prefix= \
			--mandir=/.remove \
			--datadir=/.remove \
			--with-db_path=/usr/share/misc/hddtemp.db \
			--disable-dependency-tracking \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/hddtemp.db $(TARGET_DIR)/usr/share/misc/hddtemp.db
	ln -sf /usr/share/misc/hddtemp.db $(TARGET_DIR)/etc/hddtemp.db
	$(PKG_REMOVE)
	$(TOUCH)
