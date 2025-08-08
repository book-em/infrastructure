.PHONY: run

# Usage:
# make [mode] {PROFILE}
#
# mode :=      run (default) / build / down
# PROFILE :=   [nothing] (default) / full
#

run:
	./run.sh run $(PROFILE)

build:
	./run.sh build $(PROFILE)

down:
	./run.sh down $(PROFILE)