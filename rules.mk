include $(CURDIR)/builder/symlink.mk
include $(CURDIR)/builder/directory.mk

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

modules =	\
  tests		\
  tests2

$(foreach m, $(modules), $(eval $(call _module_init,$(m))))
$(foreach m, $(modules), $(eval $(call _module_call,$(m),install)))
$(foreach m, $(modules), $(eval $(call _module_call,$(m),clean)))

install: $(addsuffix -install, $(modules))
clean:   $(addsuffix -clean,   $(modules))

dist: clean
	@cd .. && tar cjf conf.tar.bz2 conf && mv conf.tar.bz2 conf

.DEFAULT: help
