#
# links
#
LINKS_VER    = 2.20.2
LINKS_DIR    = links-$(LINKS_VER)
LINKS_SOURCE = links-$(LINKS_VER).tar.bz2
LINKS_SITE   = http://links.twibright.com/download

LINKS_PATCH  = \
	0001-links.patch \
	0002-links-ac-prog-cxx.patch \
	0003-links-accept_https_play.patch

ifeq ($(BOXMODEL), $(filter $(BOXMODEL), hd51 bre2ze4k))
LINKS_PATCH += 0004-links-input-event1.patch
else ifeq ($(BOXMODEL), $(filter $(BOXMODEL), h7))
LINKS_PATCH += 0005-links-input-event2.patch
endif

$(D)/links: bootstrap freetype libpng libjpeg-turbo openssl
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR)/intl; \
		sed -i -e 's|^T_SAVE_HTML_OPTIONS,.*|T_SAVE_HTML_OPTIONS, "HTML-Optionen speichern",|' german.lng; \
		echo "english" > index.txt; \
		echo "german" >> index.txt; \
		./gen-intl
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -vfi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--with-libjpeg \
			--without-libtiff \
			--without-svgalib \
			--without-lzma \
			--with-fb \
			--without-directfb \
			--without-pmshell \
			--without-atheos \
			--enable-graphics \
			--with-ssl=$(TARGET_DIR)/usr \
			--without-x \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_DIR)/usr/share/tuxbox/neutrino/plugins $(TARGET_DIR)/var/tuxbox/config/links
	mv $(TARGET_DIR)/usr/bin/links $(TARGET_DIR)/usr/share/tuxbox/neutrino/plugins/links.so
	echo 'name=Links Web Browser'	 > $(TARGET_DIR)/usr/share/tuxbox/neutrino/plugins/links.cfg
	echo 'desc=Web Browser'		>> $(TARGET_DIR)/usr/share/tuxbox/neutrino/plugins/links.cfg
	echo 'type=2'			>> $(TARGET_DIR)/usr/share/tuxbox/neutrino/plugins/links.cfg
	echo 'language "German"' 	 > $(TARGET_DIR)/var/tuxbox/config/links/links.cfg
	echo 'bookmarkcount=0'		 > $(TARGET_DIR)/var/tuxbox/config/bookmarks
	touch $(TARGET_DIR)/var/tuxbox/config/links/links.his
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/bookmarks.html  $(TARGET_DIR)//var/tuxbox/config/links/bookmarks.html
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/tables.tar.gz  $(TARGET_DIR)//var/tuxbox/config/links/tables.tar.gz
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
