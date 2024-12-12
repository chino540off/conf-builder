define check
$(1)-check-$(2):
	@echo -n "$(COLOUR_BLUE)CHECK$(END_COLOUR) $(2) -> "
	@echo -n "$(COLOUR_GREEN)"
	@sh -c 'command -v $(2)' || echo "$(COLOUR_YELLOW)missing command ${2}"
	@echo -n "$(END_COLOUR)"

.PHONY: $(1)-check-$(2)
endef
