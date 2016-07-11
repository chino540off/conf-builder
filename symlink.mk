define symlink-install
	@echo LN $($(1)-link-$(2))
	@ln -s $(CURDIR)/$(1)/$2 $($(1)-link-$(2))
endef

define symlink-clean
	@echo RM $($(1)-link-$(2))
	@rm -f $($(1)-link-$(2))
endef

define symlink
$(1)-link-$(2)-$(3):
	$(call symlink-$(2),$(1),$(3))

.PHONY: $(1)-link-$(2)-$(3)
endef
