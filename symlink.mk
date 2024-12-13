define symlink-install
	@echo "$(COLOUR_BLUE)LN$(END_COLOUR) $($(1)-link-$(2))"
	@ln -nfs $(CURDIR)/$(1)/$2 $($(1)-link-$(2))
endef

define symlink-clean
	@echo "$(COLOUR_BLUE)RM$(END_COLOUR) $($(1)-link-$(2))"
	@rm -f $($(1)-link-$(2))
endef

define symlink
$(1)-link-$(2)-$(3):
	$(call symlink-$(2),$(1),$(3))

.PHONY: $(1)-link-$(2)-$(3)
endef
