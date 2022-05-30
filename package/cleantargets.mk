################################################################################
#
# makefile for clean targets
#
################################################################################

%-clean:
	@printf "$(TERM_YELLOW)===> clean $(subst -clean,,$@) .. $(TERM_NORMAL)"
	$(shell find $(DEPS_DIR) -name $(subst -clean,,$@) -delete)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

depsclean:
	$(shell find $(DEPS_DIR) ! -name "*\.*" -delete )

clean: depsclean
	@printf "$(TERM_YELLOW)===> cleaning system build directories and files .. $(TERM_NORMAL)"
	@-rm -rf $(BASE_DIR)/host
	@-rm -rf $(BASE_DIR)/release
	@-rm -rf $(BASE_DIR)/root
	@-rm -rf $(DEPS_DIR)/kernel
	@-rm -rf $(DEPS_DIR)/*.do_compile
	@-rm -rf $(DEPS_DIR)/*.config.status
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

distclean:
	@printf "$(TERM_YELLOW)===> cleaning system build directories and files .. $(TERM_NORMAL)"
	@-rm -rf $(BASE_DIR)/host
	@-rm -rf $(BASE_DIR)/release
	@-rm -rf $(BASE_DIR)/root
	@-rm -rf $(BUILD_DIR)
	@-rm -rf $(SOURCE_DIR)
	@-rm -rf $(DEPS_DIR)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

# -----------------------------------------------------------------------------

PHONY += %-clean
PHONY += depsclean
PHONY += clean
PHONY += distclean
