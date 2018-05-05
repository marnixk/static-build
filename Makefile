%.PHONY: all clean

all: 
	cd src && CONFIG=../config/default.tcl ../build.sh

clean:
	rm -rf build
