#define TB_IMPL
#include "termbox2.h"

#include "misc.h"
#include "object.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
	//Arguements
	if (argc < 2) {
		printf("Not enough arguements.\n");
		exit(5);
	}
	if (argc > 2) {
		printf("Too many arguements.\n");
		exit(5);
	}

	//File
	const char *filename = argv[1]; //Maybe support other formats in the future
	const char *extension = get_extension(argv[1]);
	if (strcmp(extension, ".obj")) {
		printf("Not an .obj file.\n");
		exit(5);
	}
	if (!can_open_file(filename)) {
		printf("File too big. Max allowed size is %lu bytes.\n", MAX_FILE_BYTES);
		exit(5);
	}

	//Initializing terminal
	struct tb_event ev;
	int x = 0, y = 0;
	//tb_init();

	exit(0);
}
