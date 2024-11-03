# Makefile to compile all .erl files in the current directory

# Define a variable for the Erlang source files (all .erl files in the directory)
SRC := $(wildcard *.erl)

# Define a variable for the compiled files (all .beam files corresponding to the .erl files)
BEAMS := $(SRC:.erl=.beam)

# The default target is 'all', which compiles all .erl files
all: $(BEAMS)

# Rule to compile .erl files to .beam files using erlc
%.beam: %.erl
	erlc $<

# Clean target to remove all .beam files
clean:
	rm -f *.beam

# Phony targets to avoid file name conflicts
.PHONY: all clean
