#include "misc.h"

#include <stdbool.h>
#include <stdio.h>

//1 GiB
const unsigned long MAX_FILE_BYTES = 1024 * 1024 * 1024;

unsigned long get_file_size(const char *filename) {
	FILE *fp = fopen(filename, "r");

	if (fp == NULL) exit_with_error(0);

	if (fseek(fp, 0, SEEK_END) < 0) {
		fclose(fp);
		exit_with_error(0);
	}

	long size = ftell(fp);
	//Release the resources when not required
	fclose(fp);
	return size;
}

bool can_open_file(const char *filename) {
	return get_file_size(filename) <= MAX_FILE_BYTES;
}
