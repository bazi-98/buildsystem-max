#
# ofgwrite
#
OFGWRITE_VER    = git
OFGWRITE_DIR    = ofgwrite-max.git
OFGWRITE_SOURCE = ofgwrite-max.git
OFGWRITE_SITE   = $(MAX-GIT-GITHUB)

$(D)/ofgwrite: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_CPDIR)
	$(PKG_CHDIR); \
		$(BUILD_ENV) \
		$(MAKE); \
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite_bin $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite_caller $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite $(TARGET_DIR)/usr/bin
	$(PKG_REMOVE)
	$(TOUCH)
