define check
$(1)-check-$(2):
	@echo -n 'CHECK $(2) -> '
	@sh -c 'command -v $(2)'

.PHONY: $(1)-check-$(2)
endef
