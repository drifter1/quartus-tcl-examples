QUARTUS := quartus_sh

REPORT_DIR := reports
RTL_DIR := rtl
CONSTRS_DIR := constraints

TCL_SCRIPT := make_project.tcl

PROJ_NAME := bin2gray
DEVICE_NAME := 5CSEBA6U23I7

TCL_ARGS := $(PROJ_NAME) $(DEVICE_NAME) $(REPORT_DIR) $(RTL_DIR) $(CONSTRS_DIR)

.PHONY: project clean

project:
	@mkdir -p $(REPORT_DIR)/$(PROJ_NAME)
	$(QUARTUS) -t $(TCL_SCRIPT) $(TCL_ARGS)

clean:
	@rm -rf $(REPORT_DIR)
	@rm -rf db
	@rm -rf incremental_db
	@rm *.qpf || :
	@rm *.qsf || :
	@rm c5_pin_model_dump.txt || :
