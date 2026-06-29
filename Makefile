# -----------------------------------------------------------------------------
# Author: Simone Machetti
# -----------------------------------------------------------------------------

TOP_LEVEL ?= tmp
OUT_DIR   ?= tmp
PARAMS    ?= none

export SEL_TOP_LEVEL := $(TOP_LEVEL)
export SEL_OUT_DIR   := $(OUT_DIR)
export SEL_PARAMS    := $(PARAMS)

.PHONY: init

init:
	mkdir -p $(CODE_HOME)/ip-lib/sim
	mkdir -p $(CODE_HOME)/ip-lib/imp

sim: clean-sim
	cd $(CODE_HOME)/ip-lib/scripts/sim && \
	mkdir -p $(CODE_HOME)/ip-lib/sim/$(OUT_DIR) && \
	mkdir -p $(CODE_HOME)/ip-lib/sim/$(OUT_DIR)/build && \
	mkdir -p $(CODE_HOME)/ip-lib/sim/$(OUT_DIR)/output && \
	./run.sh && \
	if [ -f $(CODE_HOME)/ip-lib/scripts/sim/activity.vcd ]; then \
	mv $(CODE_HOME)/ip-lib/scripts/sim/activity.vcd $(CODE_HOME)/ip-lib/sim/$(OUT_DIR)/output; \
	fi

syn: clean-imp
	cd $(CODE_HOME)/ip-lib/scripts/syn && \
	mkdir -p $(CODE_HOME)/ip-lib/imp/$(OUT_DIR) && \
	mkdir -p $(CODE_HOME)/ip-lib/imp/$(OUT_DIR)/output && \
	mkdir -p $(CODE_HOME)/ip-lib/imp/$(OUT_DIR)/report && \
	yosys -l $(CODE_HOME)/ip-lib/imp/$(OUT_DIR)/output/yosys.log -c $(CODE_HOME)/ip-lib/scripts/syn/run.tcl

clean-all:
	rm -rf $(CODE_HOME)/ip-lib/sim
	rm -rf $(CODE_HOME)/ip-lib/imp

clean-sim:
	rm -rf $(CODE_HOME)/ip-lib/sim/$(OUT_DIR)

clean-imp:
	rm -rf $(CODE_HOME)/ip-lib/imp/$(OUT_DIR)
