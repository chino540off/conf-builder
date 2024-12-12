COLOUR_GREEN=\033[0;32m
COLOUR_YELLOW=\033[0;33m
COLOUR_RED=\033[0;31m
COLOUR_BLUE=\033[0;34m
END_COLOUR=\033[0m

include $(CURDIR)/builder/symlink.mk
include $(CURDIR)/builder/directory.mk
include $(CURDIR)/builder/check.mk

define _module_init
include $(CURDIR)/$(1)/rules.mk
endef

define _module_call
$(1)-$(2): $(1)-dirs-$(2) $(1)-links-$(2)

$(foreach l, $($(1)-links), $(eval $(call symlink,$(1),$(2),$(l))))
$(1)-links-$(2): $(addprefix $(1)-link-$(2)-,$($(1)-links))

$(foreach d, $($(1)-dirs), $(eval $(call directory,$(1),$(2),$(d))))
$(1)-dirs-$(2): $(addprefix $(1)-dir-$(2)-,$($(1)-dirs))

.PHONY: $(1)-$(2) $(1)-dirs-$(2) $(1)-links-$(2)
endef

define _module_check
$(foreach cmd, $($(1)-cmds), $(eval $(call check,$(1),$(cmd))))
$(1)-check: $(addprefix $(1)-check-,$($(1)-cmds))
endef

$(foreach m, $(modules), $(eval $(call _module_init,$(m))))
$(foreach m, $(modules), $(eval $(call _module_call,$(m),install)))
$(foreach m, $(modules), $(eval $(call _module_call,$(m),clean)))
$(foreach m, $(modules), $(eval $(call _module_check,$(m))))

install: check $(addsuffix -install, $(modules))
clean:   $(addsuffix -clean,   $(modules))
check:   $(addsuffix -check,   $(modules))

dist: clean
	@cd .. && tar cjf conf.tar.bz2 conf && mv conf.tar.bz2 conf

.DEFAULT: help
