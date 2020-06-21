#
# sysstat
#
SYSSTAT_VER    = 12.3.3
SYSSTAT_DIR    = sysstat-$(SYSSTAT_VER)
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VER).tar.xz
SYSSTAT_SITE   = http://pagesperso-orange.fr/sebastien.godard

$(D)/sysstat: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--docdir=/.remove \
			--disable-documentation \
			--disable-largefile \
			--disable-sensors \
			--disable-nls \
			sa_lib_dir="/usr/lib/sysstat" \
			sa_dir="/var/log/sysstat" \
			conf_dir="/etc/sysstat" \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) NLS_DIR=/.remove/locale
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
