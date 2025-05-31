#include "termbox2.h"

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void exit_with_error(int error) {
	//If the user wishes to exit without manually specifying error
	if (error != 0) errno = error;
	printf("Error %d - %s.\n", errno, strerror(errno));

	tb_present();
	tb_shutdown();

	exit(errno);
}

const char *get_extension(const char *filename) {
	char *extension = strrchr(filename, '.');
	if (extension == NULL) extension = "";
	return extension;
}
