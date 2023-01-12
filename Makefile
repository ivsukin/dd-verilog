# C++ compiler. Verilator must be compiled with the same one.
CC=g++
# C++ compiler flags. -O0 tries to increase the compilation speed
CCFLAGS=-O0
# Verilator executable. Must be in PATH
VERILATOR=verilator
# Trying to calculate the verilator's home directory
VERILATOR_HOME=$(shell echo `which verilator | rev | cut -d'/' -f3- | rev | cat`)
VERILATOR_INCLUDE=$(VERILATOR_HOME)/include
VERILATOR_CPP=$(VERILATOR_INCLUDE)/verilated.cpp $(VERILATOR_INCLUDE)/verilated_vcd_c.cpp $(VERILATOR_INCLUDE)/verilated_threads.cpp

.SILENT: all

all:
	echo "Usage: make <module_name>[-traced]"

%: %.cpp $(VERILATOR_CPP)
	@echo "Building module $* with compiler $(CC)"
	@echo "Verilating $*.v into a set of CPP files."
	@$(VERILATOR) --trace --top-module $* --cc $*.v > /dev/null 2> $*-verilating.log || (echo -e "\u001b[31mError\033[0m, please look at \u001b[33m$*-verilating.log\033[0m"; exit 1)
	@echo "Compiling verilated CPP files into a static library"
	@make -C obj_dir -f V$*.mk > /dev/null
	@echo "Compiling the testbench $*.cpp into an executable"
	@$(CC) $(CCFLAGS) $(TRACE) -DMODULE=V$* -DMODULEHEADER=\"obj_dir/V$*.h\" -I obj_dir -I$(VERILATOR_INCLUDE) $+ obj_dir/V$*__ALL.a -o $@ > /dev/null 2> $*-compiling.log || (echo -e "\u001b[31mError\033[0m, please look at \u001b[33m$*-compiling.log\033[0m"; exit 1)
	@echo -e "\u001b[32mSuccess\033[0m"
	@echo "Now you can try to launch the testbench invoking ./$*"

%-traced:
	@make $* TRACE=-DTRACE

%-lint:
	@echo -e "Linting file \u001b[33m$*.v\033[0m"
	@$(VERILATOR) --lint-only $*.v 2> $*-linting.log || (echo -e "\u001b[31mError\033[0m, please look at \u001b[33m$*-linting.log\033[0m"; exit 1)
	@echo -e "\u001b[32mSuccess\033[0m"


clean:
	@echo "Cleaning the trash"
	@-rm -rf *.exe
	@-rm -rf *.log
	@-rm -rf obj_dir
	@-rm -f $${TEST}_*
	@-rm -f *.vcd

