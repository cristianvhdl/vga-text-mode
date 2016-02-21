sp              	:= $(sp).x
dirstack_$(sp)  	:= $(d)
d               	:= $(dir)

# Synthesis sources definition
SRC_VHDL_$(d)		 	:= 
SRC_VERILOG_$(d) 	:= 

# Board specific definitions
PKG_$(d) 				 	:= xc6slx16-3-csg324

# Top module
TOP_$(d)				 	:= system

include $(d)/sources.mk

# Constraints
CONSTRAINTS_$(d) 	:= $(d)/synthesis/common.ucf

# Target path
TARGET           	:= $(call SRC_2_BIN, $(d)/$(TOP_$(d)))

# Synthesis rules
TARGETS 				 	+= $(call GEN_TARGETS, $(TARGET))

$(TARGET).prj						: $(d)/sources.mk $(SRC_VHDL_$(d)) $(SRC_VERILOG_$(d))
$(TARGET).prj						: VHDL 		:= $(SRC_VHDL_$(d))
$(TARGET).prj						: VERILOG := $(SRC_VERILOG_$(d))
$(TARGET).ucf						: $(CONSTRAINTS_$(d))

$(TARGET).xst						: PKG := $(PKG_$(d))
$(TARGET).xst						: TOP := $(TOP_$(d))

d                	:= $(dirstack_$(sp))
sp               	:= $(basename $(sp))