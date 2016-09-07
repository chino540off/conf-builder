define directory-install
	@echo MKDIR $($(1)-dir-$(2))
	@[ -d $($(1)-dir-$(2)) ] || mkdir -p $($(1)-dir-$(2))
endef

define directory-clean
	@echo RM $($(1)-dir-$(2))
	@rm -rf $($(1)-dir-$(2))
endef

define directory
$(1)-dir-$(2)-$(3):
	$(call directory-$(2),$(1),$(3))

.PHONY: $(1)-dir-$(2)-$(3)
endef
