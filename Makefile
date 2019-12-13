
install_bin_targets = setpgrp cronsh_loadenv cronsh cronshctl
install_lib_targets = cronsh-common

BINDIR = /usr/bin
LIBDIR = /usr/lib/cronsh

all: cronsh_loadenv setpgrp

cronsh_loadenv setpgrp:
	gcc $(CCFLAGS) -o $@ $@.c

install: all
	for trg in $(install_bin_targets); do \
	  install $$trg $(BINDIR)/$$trg; \
	done
	install -d $(LIBDIR)
	for trg in $(install_lib_targets); do \
	  install $$trg $(LIBDIR)/$$trg; \
	done

uninstall:
	for trg in $(install_bin_targets); do \
	  rm $(BINDIR)/$$trg; \
	done
	for trg in $(install_lib_targets); do \
	  rm $(LIBDIR)/$$trg; \
	done
	rmdir $(LIBDIR)

check_installation:
	@for trg in $(install_bin_targets); do \
	  echo -n $(BINDIR)/$$trg:" "; \
	  cmp -s $$trg $(BINDIR)/$$trg && echo MATCH || echo MISMATCH; \
	done
	@for trg in $(install_lib_targets); do \
	  echo -n $(LIBDIR)/$$trg:" "; \
	  cmp -s $$trg $(LIBDIR)/$$trg && echo MATCH || echo MISMATCH; \
	done
