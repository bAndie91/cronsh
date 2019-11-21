
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <err.h>
#include <string.h>

#define SETENV_OVERWRITE 1

int main(int argc, char** argv)
{
	FILE * envfile;
	char buf[4096];
	char * s;
	char * val;
	
	if(argc > 2)
	{
		if(envfile = fopen(argv[1], "r"))
		{
			while(fgets(buf, sizeof(buf), envfile))
			{
				if((buf[0] != '#') && (s = strchr(buf, '=')))
				{
					*s = '\0';
					val = s + 1;
					if(s = strchr(val, '\n')) *s = '\0';
					
					if(strlen(val) > 0) {
						if(setenv(buf, val, SETENV_OVERWRITE)!=0) goto fail;
					}
					else {
						if(unsetenv(buf)!=0) goto fail;
					}
				}
			}
		}
		else
		{
			if(errno != ENOENT)  /* ignore if file does not exist */
			{
				warn("open: %s", argv[1]);
				goto fail;
			}
		}
		
		execvp(argv[2], &argv[2]);
		warn("exec: %s", argv[2]);
		goto fail;
	}
	else
	{
		warnx("Usage: loadenv [env-file] [command] [arguments [...]]");
	}
	
	fail:
	return errno == 0 ? -1 : errno;
}
