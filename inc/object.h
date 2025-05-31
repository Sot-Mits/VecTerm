#ifndef OBJECT_H
#define OBJECT_H

#include <stdbool.h>

extern const unsigned long MAX_FILE_BYTES;

extern unsigned long get_file_size(const char *filename);
extern bool can_open_file(const char *filename);

#endif
