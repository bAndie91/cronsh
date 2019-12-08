# cronsh

`cronsh` is a framework for scheduled jobs. It intended to run commands from some
scheduler (eg. vixie cron) and adds common features to the jobs: organized log, locking,
repeat on failure, etc.

## Invocation

There are 3 invocation modes:

- normal mode: `cronsh CRONSH_OPTION=xyz ~/job/backup`
In this mode you may give zero or more cronsh options and a directory path where the job
script, logs and configuration are located.

- interpreter or shell mode: `cronsh -c "CRONSH_OPTION=xyz shell-command; shell-command; ..."`
This mode is for crontab. Put `SHELL=/usr/bin/cronsh` in your crontab to automatically run
every job with cronsh. You can add cronsh options in front of every crontab job's command 
line, cronsh will parse them in a limited way: no shell substitutions or inner quotes are
allowed, only `CRONSH_OPTION=xyz`, `CRONSH_OPTION="xyz"`, and `CRONSH_OPTION='xyz'`. The
rest of the command line is run by `/bin/bash`. An unique directory is created for each
job in `~/.local/share/cronsh/ad-hoc` with the full command line as directory name (forward
slashes `/` are replaced by an unicode homograph `⁄`).

- ad-hoc mode: `cronsh CRONSH_OPTION=xyz -e "shell-command; shell-command; ..."`
This is like shell mode, but cronsh options are parsed normally. An unique directory is
created for each command line like in shell mode, see there.

## Stages

## Files
