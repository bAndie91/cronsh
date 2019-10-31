
install_bin_targets = cronsh_setpgrp cronsh_loadenv cronsh cronshctl
install_lib_targets = cronsh-common

all: cronsh_loadenv cronsh_setpgrp

cronsh_loadenv cronsh_setpgrp:
	gcc $(CCFLAGS) -o $@ $@.c

install: all
	for trg in $(install_bin_targets); do \
	  install $$trg /usr/bin/$$trg; \
	done
	mkdir /usr/lib/cronsh
	for trg in $(install_lib_targets); do \
	  install $$trg /usr/lib/cronsh/$$trg; \
	done

uninstall:
	for trg in $(install_bin_targets); do \
	  rm /usr/bin/$$trg; \
	done
	for trg in $(install_lib_targets); do \
	  rm /usr/lib/cronsh/$$trg; \
	done
	rmdir /usr/lib/cronsh
