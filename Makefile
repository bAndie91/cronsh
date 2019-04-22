
all: cronsh_loadenv cronsh_setpgrp

cronsh_loadenv cronsh_setpgrp:
	gcc $(CCFLAGS) -o $@ $@.c
